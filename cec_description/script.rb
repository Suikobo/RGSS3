#******************************************************************************
#   ＊ アイテム・スキル・武器・防具の説明への制御タグ追加 ＊
#                       for RGSS3
#        Ver 1.01   2014.11.02
#   提供者：睡工房
#   This program is a free license.
#******************************************************************************

=begin
  ＜制御タグ＞
  １．スキル用制御タグ
      \制御タグ   -> 意味
      \NAME       -> 基本設定「名前｣
      \STYPE      -> 基本設定「スキルタイプ」
      \CMP        -> 基本設定「消費ＭＰ」
      \CTP        -> 基本設定「消費ＴＰ」
      \SCOPE      -> 基本設定「効果範囲｣
      \OCCASION   -> 基本設定「使用可能時」
      \SUCCESS    -> 発動「成功率」
      \REPEAT     -> 発動「連続回数」
      \GTP        -> 発動「得ＴＰ」
      \HTYPE      -> 発動「命中タイプ」
      \DTYPE      -> ダメージ「タイプ」
      \CRITICAL   -> ダメージ「会心」
      \ELEMENT    -> ダメージ「属性」
      \WEAPON1    -> 必要武器「武器タイプ１」
      \WEAPON2    -> 必要武器「武器タイプ２」
      
  ２．アイテム用制御タグ
      \制御タグ   -> 意味
      \NAME       -> 基本設定「名前｣
      \ITYPE      -> 基本設定「アイテムタイプ」
      \PRICE      -> 基本設定「価格」
      \CONSUMABLE -> 基本設定「消耗」
      \SCOPE      -> 基本設定「効果範囲｣
      \OCCASION   -> 基本設定「使用可能時」
      \SUCCESS    -> 発動「成功率」
      \REPEAT     -> 発動「連続回数」
      \GTP        -> 発動「得ＴＰ」
      \HTYPE      -> 発動「命中タイプ」
      \DTYPE      -> ダメージ「タイプ」
      \CRITICAL   -> ダメージ「会心」
      \ELEMENT    -> ダメージ「属性」
      
  ３．武器用制御タグ
      \制御タグ   -> 意味
      \NAME       -> 基本設定「名前｣
      \ETYPE      -> "武器"という文字列に変換されます。
      \WTYPE      -> 基本設定「武器タイプ」
      \PRICE      -> 基本設定「価格」
      \MHP        -> 能力値変化量「最大ＨＰ」
      \MMP        -> 能力値変化量「最大ＭＰ」
      \ATK        -> 能力値変化量「攻撃力」
      \DEF        -> 能力値変化量「防御力」
      \MATK       -> 能力値変化量「魔法力」
      \MDEF       -> 能力値変化量「魔法防御」
      \AGI        -> 能力値変化量「敏捷性」
      \LUK        -> 能力値変化量「運」
      
  ４．防具用制御タグ
      \制御タグ   -> 意味
      \NAME       -> 基本設定「名前｣
      \ETYPE      -> 基本設定「装備タイプ」
      \ATYPE      -> 基本設定「防具タイプ」
      \PRICE      -> 基本設定「価格」
      \MHP        -> 能力値変化量「最大ＨＰ」
      \MMP        -> 能力値変化量「最大ＭＰ」
      \ATK        -> 能力値変化量「攻撃力」
      \DEF        -> 能力値変化量「防御力」
      \MATK       -> 能力値変化量「魔法力」
      \MDEF       -> 能力値変化量「魔法防御」
      \AGI        -> 能力値変化量「敏捷性」
      \LUK        -> 能力値変化量「ｳ･･ ｳﾝ(._.;)」
      
  ５．スキル・アイテムの使用効果欄
      \ENAME[n]   -> n個目の使用効果の種類名
      \EVARA[n]   -> n個目の使用効果の設定値１個目
      \EVARB[n]   -> n個目の使用効果の設定値２個目
                     ※使用効果に2個目の設定値がない場合は何も表示されません
      
  ６．武器・防具の特徴欄
      \FNAME[n]   -> n個目の特徴の種類名
      \FVARA[n]   -> n個目の特徴の設定値１個目
      \FVARB[n]   -> n個目の特徴の設定値２個目
                     ※特徴に2個目の設定値がない場合は何も表示されません
      
=end


#==============================================================================
# コンフィグ項目
#==============================================================================
module SUI
module ITEM_HELP
  # アイテム・スキルの効果範囲
  SCOPE = ["なし", "敵単体", "敵全体", "敵１体ランダム", "敵２体ランダム",
  "敵３体ランダム", "敵４体ランダム", "味方単体", "味方全体",
  "味方単体（戦闘不能）", "味方全体（戦闘不能）", "使用者"]
  
  # アイテム・スキルの使用可能時
  OCCASION = ["常時", "バトルのみ", "メニューのみ", "使用不可"]
  
  # アイテム・スキルの命中タイプ
  HIT_TYPE = ["必中", "物理攻撃", "魔法攻撃"]
  
  # アイテム・スキルのダメージタイプ
  DAMAGE_TYPE = ["なし", "ＨＰダメージ", "ＭＰダメージ", "ＨＰ回復",
  "ＭＰ回復", "ＨＰ吸収", "ＭＰ吸収"]
  
  # アイテム・スキルのクリティカル
  CRITICAL = ["あり", "なし"]
  
  # アイテム・スキルのダメージ属性「通常攻撃」
  NORMAL_ATTACK = "通常攻撃"
  
  # アイテム・スキルのダメージ属性「なし」
  ELEMENT_NONE = "なし"
  
  # スキルのスキルタイプ「なし」
  STYPE_NONE = "なし"
  
  # スキルの必要武器タイプ「なし」
  WEAPON_NONE = "なし"
  
  # アイテムのアイテムタイプ
  ITYPE = ["通常", "大事なもの"]
  
  # アイテムの消耗
  CONSUMABLE = ["する", "しない"]
  
  # スキル・アイテムの使用効果（種類）
  EFFECTS = {
    11 => "ＨＰ回復", 12 => "ＭＰ回復", 13 => "ＴＰ増加",
    21 => "ステート付加", 22 => "ステート解除",
    31 => "能力強化", 32 => "能力弱体", 33 => "能力強化の解除", 34 => "能力弱体の解除",
    41 => "特殊効果", 42 => "成長", 43 => "スキル習得", 44 => "コモンイベント"
  }
  
  # スキル・アイテムの使用効果「ステート付加・解除」での０番目「通常攻撃」
  STATE_0 = "通常攻撃"
  
  # 武器・防具の特徴（種類）
  FEATURES = {
    11 => "属性有効度", 12 => "弱体有効度", 13 => "ステート有効度", 14 => "ステート無効化",
    21 => "通常能力値", 22 => "追加能力値", 23 => "特殊能力値",
    31 => "攻撃時属性", 32 => "攻撃時ステート", 33 => "攻撃速度補正", 34 => "攻撃追加回数",
    41 => "スキルタイプ追加", 42 => "スキルタイプ封印", 43 => "スキル追加", 44 => "スキル封印",
    51 => "武器タイプ装備", 52 => "防具タイプ装備", 53 => "装備固定", 54 => "装備封印", 55 => "スロットタイプ",
    61 => "行動回数追加", 62 => "特殊フラグ", 63 => "消滅エフェクト", 64 => "パーティ能力"
  }
  
  # 武器・防具の特徴「追加能力値」
  EPARAMS = ["命中率", "回避率", "会心率", "会心回避率", "魔法回避率",
  "魔法反射率", "反撃率", "ＨＰ再生率", "ＭＰ再生率", "ＴＰ再生率"]
  
  # 武器・防具の特徴「特殊能力値」
  SPARAMS = ["狙われ率", "防御効果率", "回復効果率", "薬の知識",
  "ＭＰ消費率", "ＴＰチャージ率", "物理ダメージ率", "魔法ダメージ率",
  "床ダメージ率", "経験獲得率"]
  
  # 武器・防具の特徴「スロットタイプ」
  SLOT_TYPE = ["", "二刀流"]
  
  # 武器・防具の特徴「特殊フラグ」
  SFLAG = ["自動戦闘", "防御", "身代わり", "ＴＰ持ち越し"]
  
  # 武器・防具の特徴「消滅エフェクト」
  COLLAPSE = ["", "ボス", "瞬間消去", "消えない"]
  
  # 武器・防具の特徴「パーティ能力」
  ABILITY = ["エンカウント半減", "エンカウント無効", "不意打ち無効",
  "先制攻撃率アップ", "獲得金額２倍", "アイテム入手率２倍"]
  
end
end

class Window_Help < Window_Base
  include SUI::ITEM_HELP
  #--------------------------------------------------------------------------
  # ● アイテム設定                  ※ 再定義
  #     item : スキル、アイテム等
  #--------------------------------------------------------------------------
  def set_item(item)
    text = item ? item.description.clone : ""
    set_text(convert_escape_characters_for_BaseItem(text, item))
  end
  #--------------------------------------------------------------------------
  # ○ 制御文字の事前変換（説明用）
  #--------------------------------------------------------------------------
  def convert_escape_characters_for_BaseItem(text, item)
    result = text.to_s.clone
    result.gsub!(/\\/)      { "\e" }
    result.gsub!(/\eNAME/i) { item.name }
    
    result = cec_for_UsableItem(result, item) if item.is_a?(RPG::UsableItem)
    result = cec_for_EquipItem(result, item) if item.is_a?(RPG::EquipItem)
        
    result.gsub!(/\e/)      { "\\" }
    result
  end
  #--------------------------------------------------------------------------
  # ○ 制御文字の事前変換（ UsableItem )
  #--------------------------------------------------------------------------
  def cec_for_UsableItem(result, item)
    result.gsub!(/\eSCOPE/i)    { SCOPE[item.scope] }
    result.gsub!(/\eOCCASION/i) { OCCASION[item.occasion] }
    result.gsub!(/\eSUCCESS/i)  { item.success_rate }
    result.gsub!(/\eREPEAT/i)   { item.repeats }
    result.gsub!(/\eGTP/i)      { item.tp_gain }
    result.gsub!(/\eHTYPE/i)    { HIT_TYPE[item.hit_type] }
    result.gsub!(/\eDTYPE/i)    { DAMAGE_TYPE[item.damage.type] }
    result.gsub!(/\eCRITICAL/i) { item.damage.critical ? CRITICAL[0] : CRITICAL[1] }
    result.gsub!(/\eENAME\[(\d+)\]/i) { EFFECTS[item.effects[$1.to_i].code] }
    result.gsub!(/\eEVARA\[(\d+)\]/i) { effect1($1.to_i, item) }
    result.gsub!(/\eEVARB\[(\d+)\]/i) { effect2($1.to_i, item) }
    result.gsub!(/\eELEMENT/i)  { 
      if item.damage.element_id == -1
        NORMAL_ATTACK
      elsif item.damage.element_id == 0
        ELEMENT_NONE
      else
        $data_system.elements[item.damage.element_id]
      end
    }
    
    result.gsub!(/\eENAME/i) { EFFECTS[item.effects.code] }
    result = cec_for_Skill(result, item) if item.is_a?(RPG::Skill)
    result = cec_for_Item(result, item)  if item.is_a?(RPG::Item)
    result
  end
  #--------------------------------------------------------------------------
  # ○ 制御文字の事前変換（ Skill )
  #--------------------------------------------------------------------------
  def cec_for_Skill(result, item)
    result.gsub!(/\eCMP/i)      { item.mp_cost }
    result.gsub!(/\eCTP/i)      { item.tp_cost }
    result.gsub!(/\eWEAPON1/i)    { 
      if item.required_wtype_id1  == 0
        WEAPON_NONE
      else
        $data_system.weapon_types[item.required_wtype_id1]
      end
    }
    result.gsub!(/\eWEAPON2/i)    { 
      if item.required_wtype_id2  == 0
        WEAPON_NONE
      else
        $data_system.weapon_types[item.required_wtype_id2]
      end
    }
    result.gsub!(/\eSTYPE/i)    { 
      if item.stype_id == 0
        STYPE_NONE
      else
        $data_system.skill_types[item.stype_id]
      end
    }
    result
  end
  #--------------------------------------------------------------------------
  # ○ 制御文字の事前変換（ Item )
  #--------------------------------------------------------------------------
  def cec_for_Item(result, item)
    result.gsub!(/\eITYPE/i)      { ITYPE[item.itype_id - 1] }
    result.gsub!(/\ePRICE/i)      { item.price }
    result.gsub!(/\eCONSUMABLE/i) { item.consumable ? CONSUMABLE[0] : CONSUMABLE[1] }
    result
  end
  #--------------------------------------------------------------------------
  # ○ 制御文字の事前変換（ EquipItem )
  #--------------------------------------------------------------------------
  def cec_for_EquipItem(result, item)
    result.gsub!(/\ePRICE/i) { item.price }
    result.gsub!(/\eMHP/i)   { item.params[0] }
    result.gsub!(/\eMMP/i)   { item.params[1] }
    result.gsub!(/\eATK/i)   { item.params[2] }
    result.gsub!(/\eDEF/i)   { item.params[3] }
    result.gsub!(/\eMATK/i)  { item.params[4] }
    result.gsub!(/\eMDEF/i)  { item.params[5] }
    result.gsub!(/\eAGI/i)   { item.params[6] }
    result.gsub!(/\eLUK/i)   { item.params[7] }
    result.gsub!(/\eETYPE/i) { $data_system.terms.etypes[item.etype_id] }
    result.gsub!(/\eFNAME\[(\d+)\]/i) { FEATURES[item.features[$1.to_i].code] }
    result.gsub!(/\eFVARA\[(\d+)\]/i) { features1($1.to_i, item) }
    result.gsub!(/\eFVARB\[(\d+)\]/i) { features2($1.to_i, item) }
    result = cec_for_Weapon(result, item) if item.is_a?(RPG::Weapon)
    result = cec_for_Armor(result, item)  if item.is_a?(RPG::Armor)
    result
  end
  #--------------------------------------------------------------------------
  # ○ 制御文字の事前変換（ Weapon )
  #--------------------------------------------------------------------------
  def cec_for_Weapon(result, item)
    result.gsub!(/\eWTYPE/i) { $data_system.weapon_types[item.wtype_id] }
    result
  end
  #--------------------------------------------------------------------------
  # ○ 制御文字の事前変換（ Armor )
  #--------------------------------------------------------------------------
  def cec_for_Armor(result, item)
    result.gsub!(/\eATYPE/i) { $data_system.armor_types[item.atype_id] }
    result
  end
  #--------------------------------------------------------------------------
  # ○ 使用効果のテキスト取得１
  #--------------------------------------------------------------------------
  def effect1(index, item)
    return "" if index > item.effects.size - 1
    effect = item.effects[index]
    case effect.code
      when 11, 12
        return (effect.value1 * 100).to_i.to_s
      when 13
        return effect.value1.to_i.to_s
      when 21, 22
        return STATE_0 if effect.data_id == 0
        return $data_states[effect.data_id].name
      when 31, 32, 33, 34, 42
        return $data_system.terms.params[effect.data_id]
      when 41
        return $data_system.terms.commands[1]
      when 43
        return $data_skills[effect.data_id].name
      when 44
        return $data_common_events[effect.data_id].name
      else
        return ""
    end
  end
  #--------------------------------------------------------------------------
  # ○ 使用効果のテキスト取得２
  #--------------------------------------------------------------------------
  def effect2(index, item)
    return "" if index > item.effects.size - 1
    effect = item.effects[index]
    case effect.code
      when 11, 12
        return effect.value2.to_i.to_s
      when 21, 22
        return (effect.value1 * 100).to_i.to_s
      when 31, 32, 42
        return effect.value1.to_i.to_s
      else
        return ""
    end
  end
  #--------------------------------------------------------------------------
  # ○ 特徴のテキスト取得１
  #--------------------------------------------------------------------------
  def features1(index, item)
    return "" if index > item.features.size - 1
    feature = item.features[index]
    case feature.code
      when 11, 31
        return $data_system.elements[feature.data_id]
      when 12, 21
        return $data_system.terms.params[feature.data_id]
      when 13, 14, 32
        return $data_states[feature.data_id].name
      when 22
        return EPARAMS[feature.data_id]
      when 23
        return SPARAMS[feature.data_id]
      when 33, 34
        return feature.value.to_i.to_s
      when 41, 42
        return $data_system.skill_types[feature.data_id]
      when 43, 44
        return $data_skills[feature.data_id].name
      when 51
        return $data_system.weapon_types[feature.data_id]
      when 52
        return $data_system.armor_types[feature.data_id]
      when 53, 54
        return $data_system.terms.etypes[feature.data_id]
      when 55
        return SLOT_TYPE[feature.data_id]
      when 61
        return (feature.value * 100).to_i.to_s
      when 62
        return SFLAG[feature.data_id]
      when 63
        return COLLAPSE[feature.data_id]
      when 64
        return ABILITY[feature.data_id]
      else
        return ""
    end
  end
  #--------------------------------------------------------------------------
  # ○ 特徴のテキスト取得２
  #--------------------------------------------------------------------------
  def features2(index, item)
    return "" if index > item.features.size - 1
    feature = item.features[index]
    case feature.code
      when 11, 12, 13, 21, 22, 23, 32
        return (feature.value * 100).to_i.to_s
      else
        return ""
    end
  end
end
