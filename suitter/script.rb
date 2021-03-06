#******************************************************************************
#   ＊ すいったー ＊
#                       for RGSS3
#        Ver 1.01   2014.11.16
#   提供者：睡工房
#   This program is a free license.
#******************************************************************************

=begin
    機能
      ゲーム内からTwitter投稿用のブラウザを立ち上げます。
      
      Ver 1.01 より以下の制御文字に対応しました。
      \V[n] \N[n] \P[n] \G
      ※制御文字拡張素材により拡張される場合があります。

    使い方
      １．スクリプトから操作
        a.投稿
          Suitter.post(text)
          ※改行したい場合は「\n」を使用してください。
          ※スクリプトから投稿する場合、制御文字は「\\N[n]」のように、
          　\記号を2つ繋げて使うようにしてください。

        b.付随データ修正
          Suitter.data[:url] = "http://****.***/"
          :url 以外にも以下のコンフィグ項目にあるものを修正できます。

        c.付随データのリセット
          Suitter.reset


      ２．注釈コマンドから操作
        a.投稿
          <suitter_post>
          １行目
          ２行目…

        b.付随データ修正
          <data :url http://****.***/>
          :url 以外にも以下のコンフィグ項目にあるものを修正できます。

        c.付随データのリセット
          <suitter_reset>
=end

#==============================================================================
# コンフィグ項目
#==============================================================================
module Suitter
  DEFAULT = {
  # ツイートするテキストに含めるＵＲＬ
    :url => "http://****.***/",
  
  # テキストに追加するハッシュタグ（#は書かないでください）
    :hashtags => "Suitter",
  
  # テキストに追加するVIA「@○○○さんから」(@は書かないでください)
  # :via => "rgss_user",
    :via => "",
  
  # 投稿後ページの「元のサイトに戻る」にリンクするURL
  # 通常は自サイトのURLを指定します。
    :original_referer => "http://****.***/",
  
  # 投稿後におすすめとして表示させたいユーザーＩＤ
  # 複数ユーザーＩＤを入力したい場合は「,」で区切ってください。
  # ただし、同時に表示されるのは仕様上２アカウントまでです。
  # :related => "aaa,bbb,ccc",
    :related => ""
  }
  
  # ※使用しない項目は何も入力しないでください。
end
#==============================================================================
# 設定完了
#==============================================================================


module Suitter
  #--------------------------------------------------------------------------
  # ○ 定数
  #--------------------------------------------------------------------------
  BASE  = "https://twitter.com/intent/tweet?"
  #--------------------------------------------------------------------------
  # ○ モジュールのインスタンス変数
  #--------------------------------------------------------------------------
  @post_data = DEFAULT.clone    # 付随データ
  #--------------------------------------------------------------------------
  # ○ 投稿
  #--------------------------------------------------------------------------
  def self.post(text)
    data = ["text=#{url_encode(convert_escape_characters(text))}"]
    @post_data.each do |key, value|
      data << key.to_s + "=" + url_encode(value) unless value.empty?
    end
    text = BASE + data.join("^&")
    system %Q|cmd /C "start #{text}"|;
  end
  #--------------------------------------------------------------------------
  # ○ リセット
  #--------------------------------------------------------------------------
  def self.reset
    @post_data = DEFAULT.clone
  end
  #--------------------------------------------------------------------------
  # ○ 投稿データの取得
  #--------------------------------------------------------------------------
  def self.data
    @post_data
  end
  #--------------------------------------------------------------------------
  # ○ 制御文字の事前変換(Window_Baseクラスに依存）
  #--------------------------------------------------------------------------
  def self.convert_escape_characters(text)
    window = Window_Base.new(0, 0, 0, 0)
    ret = window.convert_escape_characters(text)
    window.dispose
    ret
  end
  #--------------------------------------------------------------------------
  # ○ URLエンコード
  #--------------------------------------------------------------------------
  def self.url_encode(text)
    ret = ""
    text.split("").each do |char|
      if char =~ /[a-zA-Z0-9\.\-_]/
        ret += char
      elsif char == " "
        ret += "+"
      else
        ret += (char.unpack("C*").collect { |c| sprintf("%%%02x", c)}).join
      end
    end
    ret
  end
end


class Game_Interpreter
  #--------------------------------------------------------------------------
  # ● 注釈
  #--------------------------------------------------------------------------
  alias sui_twitter_command_108 command_108
  def command_108
    sui_twitter_command_108
    texts = []
    post = false
    @comments.each do |comment|
      case comment
        when /<suitter_post>/
          post = true
        when /<data\s+:(url|hashtags|via|original_referer|related)\s+(.+?)>/
          Suitter.data[$1.to_sym] = $2
        when /<suitter_reset>/
          Suitter.reset
        else
          texts << comment if post
      end
    end
    Suitter.post(texts.join("\n")) if post && !texts.empty?
  end
end
