require 'mini_magick'

module Mapstatic

  class Map
    DEFAULT_TILE_SIZE = 256

    attr_reader :zoom, :lat, :lng, :width, :height
    attr_accessor :tile_source

    def initialize(params={})
      if params[:bbox]
        @bounding_box = params[:bbox].split(',').map(&:to_f)
      else
        @lat    = params.fetch(:lat).to_f
        @lng    = params.fetch(:lng).to_f
        @width  = params.fetch(:width).to_f
        @height = params.fetch(:height).to_f
      end
      @zoom = params.fetch(:zoom).to_i
      @tile_source = TileSource.new(params[:provider])
      @tile_size = params.fetch(:tile_size, DEFAULT_TILE_SIZE)
    end

    def width
      @width ||= begin
        left, bottom, right, top = bounding_box_in_tiles
        (right - left) * @tile_size
      end
    end

    def height
      @height ||= begin
        left, bottom, right, top = bounding_box_in_tiles
        (bottom - top) * @tile_size
      end
    end

    def to_image
      base_image = create_uncropped_image
      base_image = fill_image_with_tiles(base_image)
      crop_to_size base_image
      base_image
    end

    def render_map(filename)
      to_image.write filename
    end

    def metadata
      {
        :bbox => bounding_box.join(','),
        :width => width.to_i,
        :height => height.to_i,
        :zoom => zoom,
        :number_of_tiles => required_tiles.length,
      }
    end

    private

    def x_tile_space
      Conversion.new.lng_to_x(lng, zoom)
    end

    def y_tile_space
      Conversion.new.lat_to_y(lat, zoom)
    end

    def width_tile_space
      width / @tile_size
    end

    def height_tile_space
      height / @tile_size
    end

    def bounding_box
      @bounding_box ||= begin
        converter = Conversion.new
        left      = converter.x_to_lng( x_tile_space - (width_tile_space / 2), zoom)
        right     = converter.x_to_lng( x_tile_space + ( width_tile_space / 2 ), zoom)
        top       = converter.y_to_lat( y_tile_space - ( height_tile_space / 2 ), zoom)
        bottom    = converter.y_to_lat( y_tile_space + ( height_tile_space / 2 ), zoom)

        [ left, bottom, right, top ]
      end
    end

    def bounding_box_in_tiles
      left, bottom, right, top = bounding_box
      converter = Conversion.new
      [
        converter.lng_to_x(left, zoom),
        converter.lat_to_y(bottom, zoom),
        converter.lng_to_x(right, zoom),
        converter.lat_to_y(top, zoom)
      ]
    end

    def required_x_tiles
      left, bottom, right, top = bounding_box_in_tiles
      Range.new(*[left, right].map(&:floor)).to_a
    end

    def required_y_tiles
      left, bottom, right, top = bounding_box_in_tiles
      Range.new(*[top, bottom].map(&:floor)).to_a
    end

    def required_tiles
      required_y_tiles.map do |y|
        required_x_tiles.map{|x| Tile.new(x,y,zoom) }
      end.flatten
    end

    def map_tiles
      @map_tiles ||= tile_source.get_tiles(required_tiles)
    end

    def crop_to_size(image)
      distance_from_left = (bounding_box_in_tiles[0] - required_x_tiles[0]) * @tile_size
      distance_from_top  = (bounding_box_in_tiles[3] - required_y_tiles[0]) * @tile_size

      image.crop "#{width}x#{height}+#{distance_from_left}+#{distance_from_top}"
    end

    def create_uncropped_image
      image = MiniMagick::Image.read(map_tiles[0])

      uncropped_width  = required_x_tiles.length * @tile_size
      uncropped_height = required_y_tiles.length * @tile_size

      image.combine_options do |c|
        c.background 'none'
        c.extent [uncropped_width,uncropped_height].join('x')
      end

      image
    end

    def fill_image_with_tiles(image)
      start = 0

      required_y_tiles.length.times do |row|
        length = required_x_tiles.length

        map_tiles.slice(start, length).each_with_index do |tile, column|
          image = image.composite( MiniMagick::Image.read(tile) ) do |c|
            c.geometry "+#{ (column) * @tile_size }+#{ (row) * @tile_size }"
          end
        end

        start += length
      end

      image
    end

  end


end
