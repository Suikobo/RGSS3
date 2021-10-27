#******************************************************************************
#   ＊ 自由選択肢 ＊
#                       for RGSS3
#        Ver 1.00   2014.11.04
#   提供者：睡工房
#   This program is a free license.
#******************************************************************************

=begin
    機能
      ４つ以上の選択肢を自由に作成できます。
      選択結果は変数に保存され、変数を使った条件分岐に使用することができます。

    使い方
    　注釈に以下の手順でコマンドを入力して使用します。
        １．選択肢開始の宣言（必ず注釈の１行目に指定）
            <choice n>
              n -> 選択結果を保存する変数ＩＤを指定します。

        ２．設定タグの指定
            <cancel n>
              キャンセルボタンを押したときに保存される数値を指定します。
              省略した場合、キャンセルボタンは無効化されます。
              ※ 何番目の選択肢か？ではありませんので注意して下さい。

            <x 絶対値 or 予約語>
              選択肢ウィンドウのＸ座標を指定します。
              省略した場合、画面の右端に配置されます。
              絶対値の他、以下の予約語を指定することができます。
                left   -> 左端に配置します。
                right  -> 右端に配置します。
                center -> 中央に配置します。

            <y 絶対値 or 予約語>
              選択肢ウィンドウのＹ座標を指定します。
              省略した場合、メッセージウィンドウの上か下に配置されます。
              絶対値の他、以下の予約語を指定することができます。
                top     -> 上端に配置します。
                bottom  -> 下端に配置します。
                center  -> 中央に配置します。
                message -> メッセージウィンドウのの上か下に配置されます。

        ３．選択肢の追加（このタグを記述した順番に選択肢は表示されます）
            <item n text>
              n    -> この選択肢を選んだ場合に保存される数値を指定します。
              text -> 選択肢として表示するテキストを指定します。

        ４．選択肢の表示
            </choice>
            ※このタグを省略した場合、注釈の最終行で表示されます。

        ※各タグは１行に複数記述できます。ただし各タグ内の改行はできません。
        ※１つの注釈に入らない場合、注釈を２つ以上連ねて使用することができます。
        　ただし、２つの注釈の間に他のイベントコマンドを挿入しないで下さい。

    ＜例＞ 選択肢１～６を画面左中央に表示し、結果を変数10番に保存する。
    <choice 10> <x 0> <y center> <cancel 15>
    <item 1 選択肢１> <item 2 選択肢２> <item 3 選択肢３>
    <item 4 選択肢４> <item 5 選択肢５> <item 6 選択肢６>
    </choice>
=end


class Game_Interpreter
  #--------------------------------------------------------------------------
  # ○ 注釈が選択肢タグとして使用されているか？
  #    <choice var=v1 [x=v2 y=v3 cancel=v4]>
  #--------------------------------------------------------------------------
  def sui_choice?(param)
    if param[0] =~ /<choice\s+\d+>/
      @sui_choice = true
      return true
    end
    return false
  end
  #--------------------------------------------------------------------------
  # ● 次のイベントコマンドのコードを取得
  #--------------------------------------------------------------------------
  alias sui_choice_next_event_code next_event_code
  def next_event_code
    code = sui_choice_next_event_code
    code = 102 if code == 108 && sui_choice?(@list[@index + 1].parameters)
    code
  end
  #--------------------------------------------------------------------------
  # ● 注釈
  #--------------------------------------------------------------------------
  alias sui_choice_choice_command_108 command_108
  def command_108
    if sui_choice?(@params)
      setup_choices(@params)
      Fiber.yield while $game_message.choice?
    end
    sui_choice_choice_command_108
  end
  #--------------------------------------------------------------------------
  # ● 選択肢のセットアップ
  #--------------------------------------------------------------------------
  alias sui_choice_setup_choices setup_choices
  def setup_choices(params)
    if @sui_choice
      sui_choices_setup
    else
      sui_choice_setup_choices(params)
    end
    @sui_choice = false
  end
  #--------------------------------------------------------------------------
  # ○ 注釈式選択肢のセットアップ
  #--------------------------------------------------------------------------
  def sui_choices_setup
    cancel = var = nil
    results = []
    
    $game_message.choice_x = :right
    $game_message.choice_y = :message
    
    get_connected_comments.each do |line|
      line.gsub(/<choice\s+(\d+)>/)                   { var = $1.to_i }
      line.gsub(/<x\s+([-+]?\d+)>/)                   { $game_message.choice_x = $1.to_i }
      line.gsub(/<x\s+(left|center|right)>/)          { $game_message.choice_x = $1.to_sym }
      line.gsub(/<y\s+([-+]?\d+)>/)                   { $game_message.choice_y = $1.to_i }
      line.gsub(/<y\s+(top|center|bottom|message)>/)  { $game_message.choice_y = $1.to_sym }
      line.gsub(/<cancel\s+(\d+)>/)                   { cancel = $1.to_i }
      line.gsub(/<item\s+(\d+)\s+(.+?)>/)             { results.push([$1.to_i, $2]) }
      break if line =~ /<\/choice>/
    end
    
    results.each {|result| $game_message.choices.push(result[1]) }
    $game_message.choice_cancel_type = :cancel if cancel
    
    $game_message.choice_proc = Proc.new {|index|
      if index == :cancel
        $game_variables[var] = cancel
      else
        $game_variables[var] = results[index][0]
      end
    }
  end
  #--------------------------------------------------------------------------
  # ○ 連続した注釈を取得
  #--------------------------------------------------------------------------
  def get_connected_comments
    cnt = 0
    comments = []
    while @list[@index + cnt].code == 108 or @list[@index + cnt].code == 408
      comments.push(@list[@index + cnt].parameters[0])
      cnt += 1
    end
    comments
  end
end


class Game_Message
  #--------------------------------------------------------------------------
  # ● 公開インスタンス変数
  #--------------------------------------------------------------------------
  attr_accessor :choice_x               # 選択肢ウィンドウＸ座標
  attr_accessor :choice_y               # 選択肢ウィンドウＹ座標
  #--------------------------------------------------------------------------
  # ● クリア
  #--------------------------------------------------------------------------
  alias sui_choice_clear clear
  def clear
    sui_choice_clear
    @choice_x = :right
    @choice_y = :message
  end
end


class Window_ChoiceList < Window_Command
  #--------------------------------------------------------------------------
  # ● ウィンドウ位置の更新
  #--------------------------------------------------------------------------
  alias sui_choice_update_placement update_placement
  def update_placement
    sui_choice_update_placement
    if $game_message.choice_x != :right
      if $game_message.choice_x == :left
        self.x = 0 if $game_message.choice_x
      elsif $game_message.choice_x == :center
        self.x = Graphics.width / 2 - self.width / 2
      else
        self.x = $game_message.choice_x
      end
    end
    if $game_message.choice_y != :message
      if $game_message.choice_y == :top
        self.y = 0
      elsif $game_message.choice_y == :center
        self.y = Graphics.height / 2 - self.height / 2
      elsif $game_message.choice_y == :bottom
        self.y = Graphics.height - self.height
      else
        self.y = $game_message.choice_y
      end
    end
  end
  #--------------------------------------------------------------------------
  # ● キャンセル処理の有効状態を取得
  #--------------------------------------------------------------------------
  alias sui_choice_cancel_enabled? cancel_enabled?
  def cancel_enabled?
    return true if $game_message.choice_cancel_type == :cancel
    sui_choice_cancel_enabled?
  end
  #--------------------------------------------------------------------------
  # ● キャンセルハンドラの呼び出し
  #--------------------------------------------------------------------------
  alias sui_choice_call_cancel_handler call_cancel_handler
  def call_cancel_handler
    if $game_message.choice_cancel_type == :cancel
      $game_message.choice_proc.call(:cancel)
      close
      return
    end
    sui_choice_call_cancel_handler
  end
end
