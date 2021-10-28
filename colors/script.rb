#******************************************************************************
#   ＊ カラーモジュール ＊
#                       for RGSS3
#        Ver 1.01   2016.11.08
#   提供者：睡工房
#   This program is a free license.
#******************************************************************************

=begin
    ◆使い方
      １．▼素材セクション以下の適当な場所に導入してください。
 
      ２．以下の書式で色を取得できます。
          Colors.get(number)        # Windowスキンのカラーパレット番号を指定
                                    # 32以上を指定した場合、拡張パレットを使用
          Colors.get(:color_name)   # コンフィグ項目のカラーネームを指定
          Colors.get("RRGGBB")      # RRGGBB形式のカラーコードを指定
          Colors.get("AARRGGBB")    # AARRGGBB形式のカラーコードを指定
=end


module Colors
#==============================================================================
# コンフィグ項目
#==============================================================================
  # メッセージの色変更タグ（\C[n]）にも対応させるか
  MESSAGE_ENABLE = true

  # 拡張カラーパレットファイル名
  # 拡張カラーパレットは"Graphics/System"フォルダ以下に保存してください。
  # パレットの規格は以下の通り。
  # 1色あたり 8×8 の塗りつぶしを、横方向に8個、縦方向に必要なだけ並べます。
  # 縦方向への拡張制限はありません。
  EXT_FILE = "Colors"
  
  # カラーネーム
  COLORS = {
  # :symbol               => "AARRGGBB",
  # :symbol               => "RRGGBB",    ※アルファ値はFFに固定されます。
    :transparent          => "00000000",
    :semitransparent      => "7F000000",
    
  
  # ☆ WEBカラー140色（カラーネーム付き）一式
  #    色サンプルは「WEBカラー140」等でネット検索してご覧下さい。
    :white                => "FFFFFF", :whitesmoke           => "F5F5F5",
    :ghostwhite           => "F8F8FF", :aliceblue            => "F0F8FF",
    :lavendar             => "E6E6FA", :azure                => "F0FFFF",
    :lightcyan            => "E0FFFF", :mintcream            => "F5FFFA",
    :honeydew             => "F0FFF0", :ivory                => "FFFFF0",
    :beige                => "F5F5DC", :lightyellow          => "FFFFE0",
    :lightgoldenrodyellow => "FAFAD2", :lemonchiffon         => "FFFACD",
    :floralwhite          => "FFFAF0", :oldlace              => "FDF5E6",
    :cornsilk             => "FFF8DC", :papayawhite          => "FFEFD5",
    :blanchedalmond       => "FFEBCD", :bisque               => "FFE4C4",
    :snow                 => "FFFAFA", :linen                => "FAF0E6",
    :antiquewhite         => "FAEBD7", :seashell             => "FFF5EE",
    :lavenderblush        => "FFF0F5", :mistyrose            => "FFE4E1",
    :gainsboro            => "DCDCDC", :lightgray            => "D3D3D3",
    :lightsteelblue       => "B0C4DE", :lightblue            => "ADD8E6",
    :lightskyblue         => "87CEFA", :powderblue           => "B0E0E6",
    :paleturquoise        => "AFEEEE", :skyblue              => "87CEEB",
    :mediumaquamarine     => "66CDAA", :aquamarine           => "7FFFD4",
    :palegreen            => "98FB98", :lightgreen           => "90EE90",
    :khaki                => "F0E68C", :palegoldenrod        => "EEE8AA",
    :moccasin             => "FFE4B5", :navajowhite          => "FFDEAD",
    :peachpuff            => "FFDAB9", :wheat                => "F5DEB3",
    :pink                 => "FFC0CB", :lightpink            => "FFB6C1",
    :thistle              => "D8BFD8", :plum                 => "DDA0DD",
    :silver               => "C0C0C0", :darkgray             => "A9A9A9",
    :lightslategray       => "778899", :slategray            => "708090",
    :slateblue            => "6A5ACD", :steelblue            => "4682B4",
    :mediumslateblue      => "7B68EE", :royalblue            => "4169E1",
    :blue                 => "0000FF", :dodgerblue           => "1E90FF",
    :cornflowerblue       => "6495ED", :deepskyblue          => "00BFFF",
    :cyan                 => "00FFFF", :aqua                 => "00FFFF",
    :turquoise            => "40E0D0", :mediumturquoise      => "48D1CC",
    :darkturquoise        => "00CED1", :lightseagreen        => "20B2AA",
    :mediumspringgreen    => "00FA9A", :springgreen          => "00FF7F",
    :lime                 => "00FF00", :limegreen            => "32CD32",
    :yellowgreen          => "9ACD32", :lawngreen            => "7CFC00",
    :chartreuse           => "7FFF00", :greenyellow          => "ADFF2F",
    :yellow               => "FFFF00", :gold                 => "FFD700",
    :orange               => "FFA500", :darkorange           => "FF8C00",
    :goldenrod            => "DAA520", :burlywood            => "DEB887",
    :tan                  => "D2B48C", :sandybrown           => "F4A460",
    :darksalmon           => "E9967A", :lightcoral           => "F08080",
    :salmon               => "FA8072", :lightsalmon          => "FFA07A",
    :coral                => "FF7F50", :tomato               => "FF6347",
    :orangered            => "FF4500", :red                  => "FF0000",
    :deeppink             => "FF1493", :hotpink              => "FF69B4",
    :palevioletred        => "DB7093", :violet               => "EE82EE",
    :orchid               => "DA70D6", :magenta              => "FF00FF",
    :fuchsia              => "FF00FF", :mediumorchid         => "BA55D3",
    :darkorchid           => "9932CC", :darkviolet           => "9400D3",
    :blueviolet           => "8A2BE2", :mediumpurple         => "9370DB",
    :gray                 => "808080", :mediumblue           => "0000CD",
    :darkcyan             => "008B8B", :cadetblue            => "5F9EA0",
    :darkseagreen         => "8FBC8F", :mediumseagreen       => "3CB371",
    :teal                 => "008080", :forestgreen          => "228B22",
    :seagreen             => "2E8B57", :darkkhaki            => "BDB76B",
    :peru                 => "CD853F", :crimson              => "DC143C",
    :indianred            => "CD5C5C", :rosybrown            => "BC8F8F",
    :mediumvioletred      => "C71585", :dimgray              => "696969",
    :black                => "000000", :midnightblue         => "191970",
    :darkslateblue        => "483D8B", :darkblue             => "00008B",
    :navy                 => "000080", :darkslategray        => "2F4F4F",
    :green                => "008000", :darkgreen            => "006400",
    :darkolivegreen       => "556B2F", :olivedrab            => "6B8E23",
    :olive                => "808000", :darkgoldenrod        => "B8860B",
    :chocolate            => "D2691E", :sienna               => "A0522D",
    :saddlebrown          => "8B4513", :firebrick            => "B22222",
    :brown                => "A52A2A", :maroon               => "800000",
    :darkred              => "8B0000", :darkmagenta          => "8B008B",
    :purple               => "800080", :indigo               => "4B0082",
  }
#==============================================================================
# 設定完了
#==============================================================================
  
  #--------------------------------------------------------------------------
  # ○ 色の取得
  #--------------------------------------------------------------------------
  def self.get(n)
    return by_index(n)  if n.is_a?(Integer)
    return by_string(n) if n.is_a?(String)
    return by_symbol(n) if n.is_a?(Symbol)
  end
  #--------------------------------------------------------------------------
  # ○ 色の取得(数値）
  #--------------------------------------------------------------------------
  def self.by_index(n)
    return by_index_extension(n - 32) if n > 31
#---------------------------------------------------< Ver 1.01 update start
#~     @windowskin ||= Cache.system("Window")
    @windowskin = Cache.system("Window") if !@windowskin || @windowskin.disposed?
#---------------------------------------------------< Ver 1.01 update end
    @windowskin.get_pixel(64 + (n % 8) * 8, 96 + (n / 8) * 8)
  end
  #--------------------------------------------------------------------------
  # ○ 色の取得(数値）　拡張パレット
  #--------------------------------------------------------------------------
  def self.by_index_extension(n)
    begin
      @extension ||= Cache.system(EXT_FILE)
      @extension.get_pixel((n % 8) * 8, (n / 8) * 8)
    rescue
      Color.new(255, 255, 255)
    end
  end
  #--------------------------------------------------------------------------
  # ○ 色の取得(文字列）
  #--------------------------------------------------------------------------
  def self.by_string(code)
    @cache ||= {}
    code = code =~ /^([0-9a-fA-F]{6}|[0-9a-fA-F]{8})$/ ? code : "00000000"
    return @cache[code] if @cache.include?(code)
    @cache[code] = create(code)
    @cache[code]
  end
  #--------------------------------------------------------------------------
  # ○ 色の取得(シンボル）
  #--------------------------------------------------------------------------
  def self.by_symbol(n)
    by_string(COLORS[n])
  end
  #--------------------------------------------------------------------------
  # ○ 色の生成
  #--------------------------------------------------------------------------
  def self.create(code)
    offset = 0
    if code.length == 8
      alpha = code[0, 2].hex
      offset = 2
    else
      alpha = 255
    end
    color = []
    3.times {|i| color << code[i * 2 + offset, 2].hex }
    Color.new(color[0], color[1], color[2], alpha)
  end
  #--------------------------------------------------------------------------
  # ○ キャッシュのクリア
  #--------------------------------------------------------------------------
  def self.clear
    @cache ||= {}
    @cache.clear
    GC.start
  end
end

if Colors::MESSAGE_ENABLE
  class Window_Base
    #--------------------------------------------------------------------------
    # ● 制御文字の引数を破壊的に取得 ※再定義
    #--------------------------------------------------------------------------
    def obtain_escape_param(text)
      param = text.slice!(/^\[:?\w+\]/)[/:?\w+/] rescue "0"
      param = param.to_i if param =~ /^\d+$/
      param = $1.to_sym if param =~ /^:{1}(\w+)$/
      param
    end
    #--------------------------------------------------------------------------
    # ● 文字色取得              ※再定義
    #     n : 文字色番号（0..31）
    #--------------------------------------------------------------------------
    def text_color(n)
      Colors.get(n)
    end
  end
end
