#******************************************************************************
#   ＊ TES基本セットモジュール ＊
#                       for RGSS3
#        Ver 1.05   2016.03.24
#   提供者：睡工房
#   This program is a free license.
#******************************************************************************

=begin
    ◆機能説明
    　ツクールのイベントコマンドを網羅した基本モジュールです。
 
    ◆注意事項
    　※このモジュールの動作には、TESの本体が必要です。
=end


if $TEST
class Tes_Validator
#----------------------------------------------------------------------------
# ◆ タグ検証の設定
#     各引数の検証方法を、@@validatesに設定します。
#----------------------------------------------------------------------------
  @@validates["message_h"] = {
  "index" => {
              :isNumeric => [0, 7]
              },
  "back"  => {
              :isNumeric => [0, 2],
              },
  "pos"   => {
              :isNumeric => [0, 2]
              }
  }
  
  @@validates["message"] = {
  "value" => {
              :notEmpty => []
              }
  }
  
  @@validates["choice_h"] = {
  "cancel"  => {
                :isNumeric => [0, 5]
                }
  }
  
  @@validates["choice_if"] = {
  "index" => {
              :notEmpty  => [],
              :isNumeric => [1, 4]
              }
  }
  
  @@validates["input_num"] = {
  "var"   => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "num"   => {
              :notEmpty  => [],
              :isNumeric => [1, 8]
              }
  }
  
  @@validates["choice_item"] = {
  "var"   => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              }
  }
  
  @@validates["scroll_h"] = {
  "speed" => {
              :notEmpty  => [],
              :isNumeric => [1, 8]
              },
  "noskip"=> {
              :isBool    => []
              }
  }
  
  @@validates["scroll"] = {
  "value" => {
              :notEmpty => []
              }
  }
  
  @@validates["sw"] = {
  "id"    => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "end"   => {
              :isNumeric => [:id, nil]
              },
  "flag"  => {
              :notEmpty  => [],
              :list      => ["on", "off"]
              }
  }
  
  @@validates["var"] = {
  "id"    => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "end"   => {
              :isNumeric => [:id, nil]
              },
  "op"    => {
              :notEmpty  => [],
              :list      => ["eq", "+", "-", "*", "/", "%"]
              },
  "value" => {
              :notEmpty  => [],
              :regCheck  => [/^[-+]{0,1}(var\.){0,1}\d+$/]
              }
  }
  
  @@validates["var_random"] = {
  "id"    => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "end"   => {
              :isNumeric => [:id, nil]
              },
  "op"    => {
              :notEmpty  => [],
              :list      => ["eq", "+", "-", "*", "/", "%"]
              },
  "min"   => {
              :notEmpty  => [],
              :isNumeric => [nil, nil]
              },
  "max"   => {
              :notEmpty  => [],
              :isNumeric => [:min, nil]
              }
  }
  
  @@validates["var_item"] = {
  "id"    => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "end"   => {
              :isNumeric => [:id, nil]
              },
  "op"    => {
              :notEmpty  => [],
              :list      => ["eq", "+", "-", "*", "/", "%"]
              },
  "value" => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              }
  }
  
  @@validates["var_weapon"] = {
  "id"    => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "end"   => {
              :isNumeric => [:id, nil]
              },
  "op"    => {
              :notEmpty  => [],
              :list      => ["eq", "+", "-", "*", "/", "%"]
              },
  "value" => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              }
  }
  
  @@validates["var_armor"] = {
  "id"    => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "end"   => {
              :isNumeric => [:id, nil]
              },
  "op"    => {
              :notEmpty  => [],
              :list      => ["eq", "+", "-", "*", "/", "%"]
              },
  "value" => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              }
  }
  
  @@validates["var_actor"] = {
  "id"    => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "end"   => {
              :isNumeric => [:id, nil]
              },
  "op"    => {
              :notEmpty  => [],
              :list      => ["eq", "+", "-", "*", "/", "%"]
              },
  "actor" => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "data"  => {
              :notEmpty  => [],
              :list      => ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
              "10", "11", "level", "exp", "hp", "mp", "maxhp", "maxmp", "atk",
              "def", "matk", "mdef", "agi", "luk"]
              }
  }
  
  @@validates["var_enemy"] = {
  "id"    => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "end"   => {
              :isNumeric => [:id, nil]
              },
  "op"    => {
              :notEmpty  => [],
              :list      => ["eq", "+", "-", "*", "/", "%"]
              },
  "enemy" => {
              :notEmpty  => [],
              :isNumeric => [0, nil]
              },
  "data"  => {
              :notEmpty  => [],
              :list      => ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
              "hp", "mp", "maxhp", "maxmp", "atk", "def", "matk", "mdef",
              "agi", "luk"]
              }
  }
  
  @@validates["var_character"] = {
  "id"    => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "end"   => {
              :isNumeric => [:id, nil]
              },
  "op"    => {
              :notEmpty  => [],
              :list      => ["eq", "+", "-", "*", "/", "%"]
              },
  "character" => {
              :notEmpty  => [],
              :isNumeric => [-1, nil]
              },
  "data"  => {
              :notEmpty  => [],
              :list      => ["0", "1", "2", "3", "4",
              "mapx", "mapy", "direction", "screenx", "screeny"]
              }
  }
  
  @@validates["var_party"] = {
  "id"    => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "end"   => {
              :isNumeric => [:id, nil]
              },
  "op"    => {
              :notEmpty  => [],
              :list      => ["eq", "+", "-", "*", "/", "%"]
              },
  "member" => {
              :notEmpty  => [],
              :isNumeric => [0, nil]
              }
  }
  
  @@validates["var_other"] = {
  "id"    => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "end"   => {
              :isNumeric => [:id, nil]
              },
  "op"    => {
              :notEmpty  => [],
              :list      => ["eq", "+", "-", "*", "/", "%"]
              },
  "data"  => {
              :notEmpty  => [],
              :list      => ["0", "1", "2", "3", "4", "5", "6", "7",
              "mapid", "members", "money", "steps", "playtime", "timer",
              "save_num", "battle_num"]
              }
  }
  
  @@validates["var_script"] = {
  "id"    => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "end"   => {
              :isNumeric => [:id, nil]
              },
  "op"    => {
              :notEmpty  => [],
              :list      => ["eq", "+", "-", "*", "/", "%"]
              },
  "script" => {
              :notEmpty  => []
              }
  }
  
  @@validates["self_sw"] = {
  "id"    => {
              :notEmpty  => [],
              :list      => ["A", "B", "C", "D"]
              },
  "flag"  => {
              :notEmpty  => [],
              :list      => ["on", "off"]
              }
  }
  
  @@validates["timer"] = {
  "flag"  => {
              :notEmpty  => [],
              :list      => ["on", "off"]
              },
  "time"  => {
              :isNumeric => [1, 5999]
              }
  }
  
  @@validates["if_sw"] = {
  "id"    => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "flag"  => {
              :list      => ["on", "off"]
              }
  }
  
  @@validates["if_var"] = {
  "id"    => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "value" => {
              :notEmpty  => [],
              :regCheck  => [/^[-+]{0,1}(var\.){0,1}\d+$/],
              :varCheck  => [/^[-+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
              },
  "op"    => {
              :list      => ["eq", "ge", "le", "gt", "lt", "ne"]
              }
  }
  
  @@validates["if_self_sw"] = {
  "id"    => {
              :notEmpty  => [],
              :list      => ["A", "B", "C", "D"]
              },
  "flag"  => {
              :list      => ["on", "off"]
              }
  }
  
  @@validates["if_timer"] = {
  "time"  => {
              :notEmpty  => [],
              :isNumeric => [0, 5999]
              },
  "op"    => {
              :list      => ["ge", "le"]
              }
  }
  
  @@validates["if_actor"] = {
  "id"    => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              },
  "type"  => {
              :list      => ["party", "name", "class", "skill", "weapon",
              "armor", "state"]
              }
  }
  
  @@validates["if_enemy"] = {
  "enemy" => {
                :notEmpty  => [],
                :isNumeric => [0, nil]
              },
  "type"  => {
              :list      => ["visible", "state"]
              },
  "value" => {
              :isNumeric => [1, nil]
              }
  }
  
  @@validates["if_character"] = {
  "id"    => {
                :notEmpty  => [],
                :isNumeric => [-1, nil]
              },
  "direction"=> {
                :notEmpty  => [],
                :list      => ["2", "4", "6", "8",
                               "left", "right", "up", "down"]
                }
  }
  
  @@validates["if_vehicle"] = {
  "vehicle" => {
                :notEmpty  => [],
                :isNumeric => [0, 2]
              }
  }
  
  @@validates["if_money"] = {
  "money" => {
              :notEmpty  => [],
              :isNumeric => [0, nil]
              },
  "op"    => {
              :list      => ["ge", "le", "lt"]
              }
  }
  
  @@validates["if_item"] = {
  "id"    => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
              }
  }
  
  @@validates["if_weapon"] = {
  "id"    => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
              },
  "equip" => {
                :isBool    => []
              }
  }
  
  @@validates["if_armor"] = {
  "id"    => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
              },
  "equip" => {
                :isBool    => []
              }
  }
  
  @@validates["if_button"] = {
  "button" => {
                :notEmpty  => [],
                :list      => ["2", "4", "6", "8",
                "11", "12", "13", "14", "15", "16", "17", "18",
                "down", "left", "right",
                "up", "A", "B", "C", "X", "Y", "Z", "L", "R"]
              }
  }
  
  @@validates["if_script"] = {
  "script" => {
                :notEmpty  => []
              }
  }
  
  @@validates["common"] = {
  "id"    => {
              :notEmpty  => [],
              :isNumeric => [1, nil]
              }
  }
  
  @@validates["label"] = {
  "value" => {
              :notEmpty => []
              }
  }
  
  @@validates["label_jump"] = {
  "value" => {
              :notEmpty => []
              }
  }
  
  @@validates["comment"] = {
  "value" => {
              :notEmpty => []
              }
  }
  
  @@validates["comment2"] = {
  "value" => {
              :notEmpty => []
              }
  }
  
  @@validates["money"] = {
  "value"   => {
                :notEmpty  => [],
                :regCheck  => [/^[-+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[-+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                }
  }
  
  @@validates["item"] = {
  "id"      => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                },
  "value"   => {
                :notEmpty  => [],
                :regCheck  => [/^[-+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[-+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                }
  }
  
  @@validates["weapon"] = {
  "id"      => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                },
  "value"   => {
                :notEmpty  => [],
                :regCheck  => [/^[-+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[-+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                },
  "equip"   => {
  				:isBool	   => []
  				}
  }
  
  @@validates["armor"] = {
  "id"      => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                },
  "value"   => {
                :notEmpty  => [],
                :regCheck  => [/^[-+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[-+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                },
  "equip"   => {
  				:isBool	   => []
  				}
  }
  
  @@validates["member"] = {
  "id"      => {
                :notEmpty  => [],
                :isNumeric => [],
                :varCheck  => [/^[-+]{0,1}(\d+)$/, 0, 1]
                },
  "init"    => {
  				:isBool	   => []
  				}
  }
  
  @@validates["hp"] = {
  "actor"   => {
                :notEmpty  => [],
                :regCheck  => [/^[+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                },
  "value"   => {
                :notEmpty  => [],
                :regCheck  => [/^[-+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[-+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                },
  "death"   => {
  				:isBool	   => []
  				}
  }
  
  @@validates["mp"] = {
  "actor"   => {
                :notEmpty  => [],
                :regCheck  => [/^[+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                },
  "value"   => {
                :notEmpty  => [],
                :regCheck  => [/^[-+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[-+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                }
  }
  
  @@validates["state"] = {
  "actor"   => {
                :notEmpty  => [],
                :regCheck  => [/^[+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                },
  "value"   => {
                :notEmpty  => [],
                :isNumeric => [nil, nil],
                :zeroCheck => []
                }
  }
  
  @@validates["all_recovery"] = {
  "actor"   => {
                :notEmpty  => [],
                :regCheck  => [/^[+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                }
  }
  
  @@validates["exp"] = {
  "actor"   => {
                :notEmpty  => [],
                :regCheck  => [/^[+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                },
  "value"   => {
                :notEmpty  => [],
                :regCheck  => [/^[-+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[-+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                },
  "message" => {
  				:isBool	   => []
  				}
  }
  
  @@validates["level"] = {
  "actor"   => {
                :notEmpty  => [],
                :regCheck  => [/^[+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                },
  "value"   => {
                :notEmpty  => [],
                :regCheck  => [/^[-+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[-+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                },
  "message" => {
  				:isBool	   => []
  				}
  }
  
  @@validates["capability"] = {
  "actor"   => {
                :notEmpty  => [],
                :regCheck  => [/^[+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                },
  "capability" => {
                :notEmpty  => [],
                :list      => ["0", "1", "2", "3", "4", "5", "6", "7",
                "maxhp", "maxmp", "atk", "def", "matk", "mdef", "agi",
                "luk" ]
                },
  "value"   => {
                :notEmpty  => [],
                :regCheck  => [/^[-+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[-+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                }
  }
  
  @@validates["skill"] = {
  "actor"   => {
                :notEmpty  => [],
                :regCheck  => [/^[+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                },
  "value"   => {
                :notEmpty  => [],
                :isNumeric => [nil, nil],
                :zeroCheck => []
                }
  }
  
  @@validates["equip"] = {
  "actor"   => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                },
  "part"    => {
                :notEmpty  => [],
                :isNumeric => [0, 4],
                },
  "id"      => {
                :notEmpty  => [],
                :isNumeric => [0, nil],
                }
  }
  
  @@validates["name"] = {
  "actor"   => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                },
  "value"    => {
                :notEmpty  => []
                }
  }
  
  @@validates["class"] = {
  "actor"   => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                },
  "value"    => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                }
  }
  
  @@validates["nickname"] = {
  "actor"   => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                },
  "value"    => {
                :notEmpty  => []
                }
  }
  
  @@validates["map_move"] = {
  "type"     => {
                :list      => ["const", "var"]
                },
  "map"      => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                },
  "x"        => {
                :notEmpty  => [],
                :isNumeric => [0, nil],
                :varCheck2 => ["type"]
                },
  "y"        => {
                :notEmpty  => [],
                :isNumeric => [0, nil],
                :varCheck2 => ["type"]
                },
  "direction"=> {
                :list      => ["0", "2", "4", "6", "8",
                               "left", "right", "up", "down"]
                },
  "fade"     => {
                :list      => ["0", "1", "2", "black", "white", "none"]
                }
  }
  
  @@validates["vehicle_pos"] = {
  "vehicle"  => {
                :notEmpty  => [],
                :isNumeric => [0, 2]
                },
  "type"     => {
                :list      => ["const", "var"]
                },
  "map"      => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                },
  "x"        => {
                :notEmpty  => [],
                :isNumeric => [0, nil],
                :varCheck2 => ["type"]
                },
  "y"        => {
                :notEmpty  => [],
                :isNumeric => [0, nil],
                :varCheck2 => ["type"]
                }
  }
  
  @@validates["event_pos"] = {
  "id"       => {
                :notEmpty  => [],
                :isNumeric => [-1, nil]
                },
  "type"     => {
                :list      => ["const", "var", "target"]
                },
  "x"        => {
                :notEmpty  => [],
                :isNumeric => [0, nil],
                :varCheck2 => ["type"],
                },
  "y"        => {
                :notEmpty  => [],
                :isNumeric => [0, nil],
                :varCheck2 => ["type"]
                },
  "direction"=> {
                :list      => ["0", "2", "4", "6", "8",
                               "left", "right", "up", "down"]
                }
  }
  
  @@validates["scroll_map"] = {
  "direction"=> {
                :notEmpty  => [],
                :list      => ["2", "4", "6", "8",
                               "left", "right", "up", "down"]
                },
  "num"      => {
                :notEmpty  => [],
                :isNumeric => [0, 100]
                },
  "speed"    => {
                :isNumeric => [1, 6]
                }
  }
  
  @@validates["route_h"] = {
  "event"   => {
                :notEmpty  => [],
                :isNumeric => [-1, nil]
                },
  "repeat"  => {
                :isBool    => []
                },
  "skip"    => {
                :isBool    => []
                },
  "wait"    => {
                :isBool    => []
                }
  }
  
  @@validates["transparent"] = {
  "flag"    => {
                :notEmpty  => [],
                :list      => ["on", "off"]
                }
  }
  
  @@validates["followers"] = {
  "flag"    => {
                :notEmpty  => [],
                :list      => ["on", "off"]
                }
  }
  
  @@validates["anime"] = {
  "target"  => {
                :notEmpty  => [],
                :isNumeric => [-1, nil]
                },
  "anime"   => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                },
  "wait"    => {
                :isBool    => []
                }
  }
  
  @@validates["balloon"] = {
  "target"  => {
                :notEmpty  => [],
                :isNumeric => [-1, nil]
                },
  "balloon" => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                },
  "wait"    => {
                :isBool    => []
                }
  }
  
  @@validates["tone"] = {
  "red"     => {
                :isNumeric => [-255, 255]
                },
  "green"   => {
                :isNumeric => [-255, 255]
                },
  "blue"    => {
                :isNumeric => [-255, 255]
                },
  "gray"    => {
                :isNumeric => [0, 255]
                },
  "time"    => {
                :isNumeric => [1, 600]
                },
  "wait"    => {
                :isBool    => []
                }
  }
  
  @@validates["flash"] = {
  "red"     => {
                :isNumeric => [0, 255]
                },
  "green"   => {
                :isNumeric => [0, 255]
                },
  "blue"    => {
                :isNumeric => [0, 255]
                },
  "strength"=> {
                :isNumeric => [0, 255]
                },
  "time"    => {
                :isNumeric => [1, 600]
                },
  "wait"    => {
                :isBool    => []
                }
  }
  
  @@validates["shake"] = {
  "strength"=> {
                :isNumeric => [1, 9]
                },
  "speed"   => {
                :isNumeric => [1, 9]
                },
  "time"    => {
                :isNumeric => [1, 600]
                },
  "wait"    => {
                :isBool    => []
                }
  }
  
  @@validates["wait"] = {
  "time"    => {
                :isNumeric => [1, 999]
                }
  }
  
  @@validates["picture"] = {
  "layer"   => {
                :notEmpty  => [],
                :isNumeric => [1, 100]
                },
  "file"    => {
                :notEmpty  => []
                },
  "origin"  => {
                :list      => ["ul", "center"]
                },
  "type"    => {
                :list      => ["const", "var"]
                },
  "x"       => {
                :notEmpty  => [],
                :isNumeric => [-9999, 9999],
                :varCheck2 => ["type"]
                },
  "y"       => {
                :notEmpty  => [],
                :isNumeric => [-9999, 9999],
                :varCheck2 => ["type"]
                },
  "zoom_x"  => {
                :isNumeric => [0, 2000]
                },
  "zoom_y"  => {
                :isNumeric => [0, 2000]
                },
  "transparent"=> {
                :isNumeric => [0, 255]
                },
  "blend"   => {
                :isNumeric => [0, 2]
                }
  }
  
  @@validates["picture_move"] = {
  "layer"   => {
                :notEmpty  => [],
                :isNumeric => [1, 100]
                },
  "origin"  => {
                :list      => ["ul", "center"]
                },
  "type"    => {
                :list      => ["const", "var"]
                },
  "x"       => {
                :notEmpty  => [],
                :isNumeric => [-9999, 9999],
                :varCheck2 => ["type"]
                },
  "y"       => {
                :notEmpty  => [],
                :isNumeric => [-9999, 9999],
                :varCheck2 => ["type"]
                },
  "zoom_x"  => {
                :isNumeric => [0, 2000]
                },
  "zoom_y"  => {
                :isNumeric => [0, 2000]
                },
  "transparent"=> {
                :isNumeric => [0, 255]
                },
  "blend"   => {
                :isNumeric => [0, 2]
                },
  "time"    => {
                :isNumeric => [1, 600]
                },
  "wait"    => {
                :isBool    => []
                }
  }
  
  @@validates["picture_rotation"] = {
  "layer"   => {
                :notEmpty  => [],
                :isNumeric => [1, 100]
                },
  "speed"   => {
                :isNumeric => [-90, 90]
                }
  }
  
  @@validates["picture_tone"] = {
  "layer"   => {
                :notEmpty  => [],
                :isNumeric => [1, 100]
                },
  "red"     => {
                :isNumeric => [-255, 255]
                },
  "green"   => {
                :isNumeric => [-255, 255]
                },
  "blue"    => {
                :isNumeric => [-255, 255]
                },
  "gray"    => {
                :isNumeric => [0, 255]
                },
  "time"    => {
                :isNumeric => [0, 600]
                },
  "wait"    => {
                :isBool    => []
                }
  }
  
  @@validates["picture_erace"] = {
  "layer"   => {
                :notEmpty  => [],
                :isNumeric => [1, 100]
                }
  }
  
  @@validates["weather"] = {
  "weather" => {
                :list      => ["none", "rain", "storm", "snow"]
                },
  "strength"=> {
                :isNumeric => [1, 9]
                },
  "time"    => {
                :isNumeric => [0, 600]
                },
  "wait"    => {
                :isBool    => []
                }
  }
  
  @@validates["bgm"] = {
  "volume"  => {
                :isNumeric => [0, 100]
                },
  "pitch"   => {
                :isNumeric => [50, 150]
                }
  }
  
  @@validates["fadeout_bgm"] = {
  "time"    => {
                :isNumeric => [1, 60]
                }
  }
  
  @@validates["bgs"] = {
  "volume"  => {
                :isNumeric => [0, 100]
                },
  "pitch"   => {
                :isNumeric => [50, 150]
                }
  }
  
  @@validates["fadeout_bgs"] = {
  "time"    => {
                :isNumeric => [1, 60]
                }
  }
  
  @@validates["me"] = {
  "volume"  => {
                :isNumeric => [0, 100]
                },
  "pitch"   => {
                :isNumeric => [50, 150]
                }
  }
  
  @@validates["se"] = {
  "volume"  => {
                :isNumeric => [0, 100]
                },
  "pitch"   => {
                :isNumeric => [50, 150]
                }
  }
  
  @@validates["battle"] = {
  "id"      => {
                :notEmpty  => [],
                :regCheck  => [/^(var\.){0,1}\d+$/],
                :varCheck  => [/^(var\.){0,1}(\d+)$/, 1, 2]
                },
  "can_escape"   => {
                :isBool => []
                },
  "loss_continue"=> {
                :isBool => []
                }
  }
  
  @@validates["shop"] = {
  "type"    => {
                :notEmpty  => [],
                :list      => ["0", "1", "2", "item", "weapon", "armor"],
                },
  "id"      => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                },
  "price"   => {
                :list      => ["db", "value"]
                },
  "value"   => {
                :isNumeric => [0, 9999999]
                },
  "buy_only"=> {
                :isBool    => []
                }
  }
  
  @@validates["input_name"] = {
  "actor"   => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                },
  "number"  => {
                :isNumeric => [1, 16]
                }
  }
  
  @@validates["battle_bgm"] = {
  "volume"  => {
                :isNumeric => [0, 100]
                },
  "pitch"   => {
                :isNumeric => [50, 150]
                }
  }
  
  @@validates["battle_end_me"] = {
  "volume"  => {
                :isNumeric => [0, 100]
                },
  "pitch"   => {
                :isNumeric => [50, 150]
                }
  }
  
  @@validates["save_disable"] = {
  "flag"    => {
                :isBool    => []
                }
  }
  
  @@validates["menu_disable"] = {
  "flag"    => {
                :isBool    => []
                }
  }
  
  @@validates["encount_disable"] = {
  "flag"    => {
                :isBool    => []
                }
  }
  
  @@validates["formation_disable"] = {
  "flag"    => {
                :isBool    => []
                }
  }
  
  @@validates["window_color"] = {
  "red"     => {
                :isNumeric => [-255, 255]
                },
  "green"   => {
                :isNumeric => [-255, 255]
                },
  "blue"    => {
                :isNumeric => [-255, 255]
                }
  }
  
  @@validates["actor_graphic"] = {
  "actor"     => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                },
  "walk_index"=> {
                :isNumeric => [0, 7]
                },
  "face_index"=> {
                :isNumeric => [0, 7]
                }
  }
  
  @@validates["vehicle_graphic"] = {
  "vehicle" => {
                :notEmpty  => [],
                :isNumeric => [0, 2]
                },
  "index"   => {
                :isNumeric => [0, 7]
                }
  }
  
  @@validates["movie"] = {
  "file"    => {
                :notEmpty  => []
                }
  }
  
  @@validates["map_name_disable"] = {
  "flag"    => {
                :isBool    => []
                }
  }
  
  @@validates["tileset"] = {
  "id"      => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                }
  }
  
  @@validates["parallax"] = {
  "loop_x"  => {
                :isBool    => []
                },
  "scroll_x"=> {
                :isNumeric => [-32, 32]
                },
  "loop_y"  => {
                :isBool    => []
                },
  "scroll_y"=> {
                :isNumeric => [-32, 32]
                }
  }
  
  @@validates["pos_info"] = {
  "var"     => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                },
  "type"    => {
                :isNumeric => [0, 5]
                },
  "pos"     => {
                :list      => ["const", "var"]
                },
  "x"       => {
                :notEmpty  => [],
                :isNumeric => [0, nil],
                :varCheck2 => ["pos"]
                },
  "y"       => {
                :notEmpty  => [],
                :isNumeric => [0, nil],
                :varCheck2 => ["pos"]
                }
  }
  
  @@validates["enemy_hp"] = {
  "enemy"   => {
                :notEmpty  => [],
                :isNumeric => [-1, nil]
                },
  "value"   => {
                :notEmpty  => [],
                :regCheck  => [/^[-+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[-+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                },
  "death"   => {
  				:isBool	   => []
  				}
  }
  
  @@validates["enemy_mp"] = {
  "enemy"   => {
                :notEmpty  => [],
                :isNumeric => [-1, nil]
                },
  "value"   => {
                :notEmpty  => [],
                :regCheck  => [/^[-+]{0,1}(var\.){0,1}\d+$/],
                :varCheck  => [/^[-+]{0,1}(var\.){0,1}(\d+)$/, 1, 2]
                }
  }
  
  @@validates["enemy_state"] = {
  "enemy"   => {
                :notEmpty  => [],
                :isNumeric => [-1, nil]
                },
  "value"   => {
                :notEmpty  => [],
                :isNumeric => [nil, nil],
                :zeroCheck => []
                }
  }
  
  @@validates["enemy_all_recovery"] = {
  "enemy"   => {
                :notEmpty  => [],
                :isNumeric => [-1, nil]
                }
  }
  
  @@validates["enemy_appear"] = {
  "enemy"   => {
                :notEmpty  => [],
                :isNumeric => [-1, nil]
                }
  }
  
  @@validates["enemy_trans"] = {
  "enemy"   => {
                :notEmpty  => [],
                :isNumeric => [-1, nil]
                },
  "trans"   => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                }
  }
  
  @@validates["battle_anime"] = {
  "enemy"   => {
                :notEmpty  => [],
                :isNumeric => [-1, nil]
                },
  "anime"   => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                }
  }
  
  @@validates["force"] = {
  "battler" => {
                :notEmpty  => [],
                :list      => ["actor", "enemy"],
                },
  "id"      => {
                :notEmpty  => [],
                :isNumeric => [-1, nil]
                },
  "skill"   => {
                :notEmpty  => [],
                :isNumeric => [1, nil]
                },
  "target"  => {
                :notEmpty  => [],
                :isNumeric => [-2, nil]
                }
  }
  
  @@validates["script"] = {
#~   "value" => {                       # Ver 1.05
#~               :notEmpty => []        # Ver 1.05
#~               }                      # Ver 1.05
  }
  
  @@validates["script2"] = {
#~   "value" => {                       # Ver 1.05
#~               :notEmpty => []        # Ver 1.05
#~               }                      # Ver 1.05
  }
end

class Tes_Splitter
#----------------------------------------------------------------------------
# ◆ コマンド分割用メソッド仕様
#       メソッド名   split_タグ名
#       返り値       なし
#----------------------------------------------------------------------------
  #--------------------------------------------------------------------------
  # ○ 分割処理　：選択肢の表示（ヘッダ）
  #--------------------------------------------------------------------------
  def split_choice_h
    text = get_line
    labels = []
    temp = {}
    if args = text["choice_h".size + 1, 9999].strip
      args.gsub!(/\s*=\s*/) { "<=>" }
      args.split(/\s+/).each do |arg|
        key, param = arg.split("<=>", 2)
        if key.downcase == "label"
          labels << param
        elsif key.downcase == "cancel"
          temp["cancel"] = param
        end
      end
    end
    temp["labels"] = labels
    @data << ["choice_h", temp, line_number]
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理　：選択肢の表示（分岐部）
  #--------------------------------------------------------------------------
  def split_choice_if
    if @data.empty? or (@data[-1][0] != "choice_h" and @data[-1][0] != "end")
      raise(TesSyntaxError,
      "選択肢分岐前にヘッダまたは終端タグがありません。")
    end
    split_normal
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理　：選択肢の表示（キャンセル部）
  #--------------------------------------------------------------------------
  def split_choice_cancel
    if @data.empty? or (@data[-1][0] != "choice_h" and @data[-1][0] != "end")
      raise(TesSyntaxError,
      "選択肢分岐前にヘッダまたは終端タグがありません。")
    end
    split_normal
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理　：文章スクロールの表示
  #--------------------------------------------------------------------------
  def split_scroll_h
    split_normal  # ヘッダを一般処理
    
    # 文章本体格納
    messages = []
    until eoc?
      break unless next_message?  # メッセージ行以外が来るまで格納
      @index += 1
      messages << ["scroll", {"value" => get_line}, line_number]
    end
    if messages.size == 0
      raise(TesSyntaxError, "文章スクロールの中身がありません。")
    end
    @data += messages
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（一般）
  #--------------------------------------------------------------------------
  def split_var
    @lines[@index][0].gsub!(/=\s*=/) { "=eq" }
    split_normal
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（ランダム）
  #--------------------------------------------------------------------------
  def split_var_random
    split_var
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（アイテム）
  #--------------------------------------------------------------------------
  def split_var_item
    split_var
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（武器）
  #--------------------------------------------------------------------------
  def split_var_weapon
    split_var
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（防具）
  #--------------------------------------------------------------------------
  def split_var_armor
    split_var
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（アクター）
  #--------------------------------------------------------------------------
  def split_var_actor
    split_var
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（敵キャラ）
  #--------------------------------------------------------------------------
  def split_var_enemy
    split_var
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（キャラクター）
  #--------------------------------------------------------------------------
  def split_var_character
    split_var
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（パーティ）
  #--------------------------------------------------------------------------
  def split_var_party
    split_var
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（スクリプト）
  #--------------------------------------------------------------------------
  def split_var_script
    result = "@var_script"
    text = @lines[@index][0]
    text.gsub!(/@var_script/) {""}
    text.gsub!(/(id\s*=\s*\d+)/) {""}
    result += " " + $1
    text.gsub!(/(end\s*=\s*\d+)/) {""}
    result += " " + $1 if $1
    text.gsub!(/(op\s*=\s*[-+=*\/%])/) {""}
    result += " " + $1 if $1
    text.gsub!(/script\s*=\s*/) {""}
    text.gsub!(/=/) {"<!!>"}
    text.strip!.gsub!(/\s/) {"<ii>"}
    @lines[@index][0] = result + " script=" + text.strip
    split_var
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（その他）
  #--------------------------------------------------------------------------
  def split_var_other
    split_var
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（変数）
  #--------------------------------------------------------------------------
  def split_if_var
    @lines[@index][0].gsub!(/=\s*<>|=\s*></) { "=ne" }  # 不等号
    @lines[@index][0].gsub!(/=\s*>=|=\s*=>/) { "=ge" }  # 以上
    @lines[@index][0].gsub!(/=\s*<=|=\s*=</) { "=le" }  # 以下
    @lines[@index][0].gsub!(/=\s*>/)         { "=gt" }  # 超
    @lines[@index][0].gsub!(/=\s*</)         { "=lt" }  # 未満
    @lines[@index][0].gsub!(/=\s*=/)         { "=eq" }  # 等号
    split_normal
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（タイマー）
  #--------------------------------------------------------------------------
  def split_if_timer
    split_if_var
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（お金）
  #--------------------------------------------------------------------------
  def split_if_money
    split_if_var
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（スクリプト）
  #--------------------------------------------------------------------------
  def split_if_script
    text = @lines[@index][0]
    text.gsub!(/script\s*=\s*(.+)/) {""}
    temp = $1.gsub(/=/) {"<!!>"}
    temp.gsub!(/\s/) {"<ii>"}
    @lines[@index][0] = text + " script=" + temp
    split_if_var
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理　：注釈の開始
  #--------------------------------------------------------------------------
  def split_comment
    comments = []
    @index += 1
    until eoc?
      break if get_command_name(get_line) == "comment_end"
      comments << ["comment2", {"value" => get_line}, line_number]
      @index += 1
    end
    if eoc?
      raise(TesSyntaxError, "コメントタグが閉じられていません。")
    end
    unless comments.empty?
      comments[0][0] = "comment" # 先頭のタグ名修正
      @data += comments
    end
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理　：注釈の終了
  #--------------------------------------------------------------------------
  def split_comment_end
    raise(TesSyntaxError, "コメントタグが開始されていません。")
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理　：移動ルートの設定（ヘッダ）
  #--------------------------------------------------------------------------
  def split_route_h
    split_normal  # ヘッダはそのまま一般処理
    
    # 移動ルート格納
    route_number = 0
    until eoc?
      break if get_command_name(get_next_line) != "route"
      @index += 1
      route_number += 1
      split_route2
    end
    if route_number == 0
      raise(TesSyntaxError, "移動ルートが設定されていません。")
    end
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理　：移動ルートのパラメータ分割
  #--------------------------------------------------------------------------
  def split_route2
    # スクリプト以外は通常分割
    return split_normal unless @lines[@index][0].include?("script")
    if cmd = get_command_name(@lines[@index][0])
      if args = @lines[@index][0][cmd.size + 1, 9999].strip
        temp = "@route type=45 script="
        args.gsub!(/type\s*=\s*45/) {""}
        args.gsub!(/script\s*=\s*/) {""}
        args.gsub!(/=/) {"<!!>"}
        args.gsub!(/\s/) {"<ii>"}
        temp += args
        @lines[@index][0] = temp
        split_normal
      end
    end
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理　：移動ルート
  #--------------------------------------------------------------------------
  def split_route
    raise(TesSyntaxError, "移動ルートのヘッダがありません。")
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理　：バトルの処理（勝った場合）
  #--------------------------------------------------------------------------
  def split_battle_win
    if @data.empty? or (@data[-1][0] != "battle" and @data[-1][0] != "end")
      raise(TesSyntaxError,
      "戦闘分岐前にヘッダまたは終端タグがありません。")
    end
    split_normal
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理　：バトルの処理（逃げた場合）
  #--------------------------------------------------------------------------
  def split_battle_escape
    split_battle_win
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理　：バトルの処理（負けた場合）
  #--------------------------------------------------------------------------
  def split_battle_loss
    split_battle_win
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理　：スクリプトの開始
  #--------------------------------------------------------------------------
  def split_script
    scripts = []
    @index += 1
    until eoc?
      break if get_command_name(get_line) == "script_end"
      scripts << ["script2", {"value" => get_line}, line_number]
      @index += 1
    end
    if eoc?
      raise(TesSyntaxError, "スクリプトタグが閉じられていません。")
    end
    unless scripts.empty?
      scripts[0][0] = "script" # 先頭のタグ名修正
      @data += scripts
    end
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理　：スクリプトの終了
  #--------------------------------------------------------------------------
  def split_script_end
    raise(TesSyntaxError, "スクリプトタグが開始されていません。")
  end
end

class Tes_Validator
#----------------------------------------------------------------------------
# ◆ 検証用メソッド仕様
#       共通メソッド名   validate_検証名
#       共通引数         vargs           検証に必要な指示リスト
#                        param_name      検証中の引数名
#                        params          TESコマンドの引数リスト
#    検証結果に異常がある場合は例外を投げてください。
#----------------------------------------------------------------------------
  #--------------------------------------------------------------------------
  # ○ 必須要素
  #--------------------------------------------------------------------------
  def validate_notEmpty(vargs, param_name, params)
    if !params[param_name] or params[param_name].empty?
      raise(TesValidateError,
      "[#{param_name}] : 必須引数が省略されています。")
    end
  end
  #--------------------------------------------------------------------------
  # ○ 真偽値チェック
  #--------------------------------------------------------------------------
  def validate_isBool(vargs, param_name, params)
    return unless params[param_name]
    unless params[param_name] =~ /^(true|false)$/i
      raise(TesValidateError,
      "[#{param_name}] : true/false 以外が代入されました。")
    end
  end
  #--------------------------------------------------------------------------
  # ○ 数値チェック
  #     vargs[0] : 最小値（nilで無効）
  #     vargs[1] : 最大値（nilで無効）
  #--------------------------------------------------------------------------
  def validate_isNumeric(vargs, param_name, params)
    return unless params[param_name]
    unless params[param_name] =~ /^[-+0-9]\d*$/
      raise(TesValidateError,
      "[#{param_name}] : 数値以外が代入されました。")
    end
    
    # 最小値判定
    if min = vargs[0]
      min = params[min.id2name] if min.is_a?(Symbol)
      min = eval(min) if min.is_a?(String)
      min = min.to_i
      if params[param_name].to_i < min
        raise(TesValidateError,
        "[#{param_name}] : 最小値より小さい値が使われています。")
      end
    end
    
    # 最大値判定
    if max = vargs[1]
      max = params[max.id2name] if max.is_a?(Symbol)
      max = eval(max) if max.is_a?(String)
      max = max.to_i
      if params[param_name].to_i > max
        raise(TesValidateError,
        "[#{param_name}] : 最大値より大きい値が使われています。")
      end
    end
  end
  #--------------------------------------------------------------------------
  # ○ リスト
  #		vargs : 許可された値のリスト（例：["A", "B", "C", "D"]）
  #--------------------------------------------------------------------------
  def validate_list(vargs, param_name, params)
    return unless params[param_name]
    unless vargs.include?(params[param_name])
      raise(TesValidateError,
      "[#{param_name}] : 許可されていない値が使われました。")
    end
  end
  #--------------------------------------------------------------------------
  # ○ ０以外のチェック
  #--------------------------------------------------------------------------
  def validate_zeroCheck(vargs, param_name, params)
    return unless params[param_name]
    if params[param_name].to_i == 0
      raise(TesValidateError,
      "[#{param_name}] : 「0」が使われました。")
    end
  end
  #--------------------------------------------------------------------------
  # ○ 正規表現でチェック
  #	  vargs[0] : 正規表現
  #--------------------------------------------------------------------------
  def validate_regCheck(vargs, param_name, params)
    return unless params[param_name]
    unless params[param_name] =~ vargs[0]
      raise(TesValidateError,
      "[#{param_name}] : 正規表現にマッチしませんでした。")
    end
  end
  #--------------------------------------------------------------------------
  # ○ 変数の値チェック
  #	  vargs[0] : 正規表現
  #		vargs[1] : 変数判断位置
  #		vargs[2] : 変数ＩＤの位置
  #--------------------------------------------------------------------------
  def validate_varCheck(vargs, param_name, params)
    return unless params[param_name]
    params[param_name] =~ vargs[0]
    return unless Regexp.last_match(vargs[1])    # 変数指定ではない
    if Regexp.last_match(vargs[2]).to_i == 0
      raise(TesValidateError,
      "[#{param_name}] : 「0」が使われました。")
    end
  end
  #--------------------------------------------------------------------------
  # ○ 変数の値チェック２
  #	   	引数 0: 数値/変数を指定している引数名
  #--------------------------------------------------------------------------
  def validate_varCheck2(vargs, param_name, params)
    return unless params[param_name]
    return if params[vargs[0]] != "var"         # 変数指定ではない
    if params[param_name].to_i == 0
      raise(TesValidateError,
      "[#{param_name}] : 「0」が使われました。")
    end
  end
end

class Tes_Converter
#----------------------------------------------------------------------------
# ◆ 変換用メソッド仕様
#       メソッド名   convert_タグ名
#       引数         args            タグに渡された引数のリスト
#       返り値       PRG::EventCommandのオブジェクト
#----------------------------------------------------------------------------

#****************************************************************************
# メッセージ系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ 文章の表示（ヘッダー部）
  #--------------------------------------------------------------------------
  def convert_message_h(args)
    file  = (args["actor"] || "")
    index = (args["index"] || 0).to_i
    back  = (args["back"]  || 0).to_i
    pos   = (args["pos"]   || 2).to_i
    return RPG::EventCommand.new(101, @indent, [file, index, back, pos])
  end
  #--------------------------------------------------------------------------
  # ○ 文章の表示（文字部）
  #--------------------------------------------------------------------------
  def convert_message(args)
    return RPG::EventCommand.new(401, @indent,
                                           [args["value"].gsub(/^_/) { "" }])
  end
  #--------------------------------------------------------------------------
  # ○ 選択肢の表示（ヘッダー部）
  #--------------------------------------------------------------------------
  def convert_choice_h(args)
    texts = args["labels"]
    if texts.size == 0
      raise(TesConvertError, "ラベルが１つも指示されていません。")
    end
    flag = (args["cancel"] || texts.size).to_i
    return RPG::EventCommand.new(102, @indent, [texts, flag])
  end
  #--------------------------------------------------------------------------
  # ○ 選択肢の表示（分岐部）
  #--------------------------------------------------------------------------
  def convert_choice_if(args)
    @indent += 1
    return RPG::EventCommand.new(402, @indent - 1, [args["index"].to_i - 1])
  end
  #--------------------------------------------------------------------------
  # ○ 選択肢の表示（キャンセル時）
  #--------------------------------------------------------------------------
  def convert_choice_cancel(args)
    @indent += 1
    return RPG::EventCommand.new(403, @indent - 1, [])
  end
  #--------------------------------------------------------------------------
  # ○ 選択肢の表示（選択肢の終了）
  #--------------------------------------------------------------------------
  def convert_choice_end(args)
    return RPG::EventCommand.new(404, @indent, [])
  end
  #--------------------------------------------------------------------------
  # ○ 数値入力の処理
  #--------------------------------------------------------------------------
  def convert_input_num(args)
    return RPG::EventCommand.new(103, @indent,
                                        [args["var"].to_i, args["num"].to_i])
  end
  #--------------------------------------------------------------------------
  # ○ アイテム選択の処理
  #--------------------------------------------------------------------------
  def convert_choice_item(args)
    return RPG::EventCommand.new(104, @indent, [args["var"].to_i])
  end
  #--------------------------------------------------------------------------
  # ○ 文章スクロール表示（ヘッダー部）
  #--------------------------------------------------------------------------
  def convert_scroll_h(args)
    @scroll = true
    flag = (args["noskip"] || "false") == "true" ? true : false
    return RPG::EventCommand.new(105, @indent, [args["speed"].to_i, flag])
  end
  #--------------------------------------------------------------------------
  # ○ 文章スクロール表示（文章部）
  #--------------------------------------------------------------------------
  def convert_scroll(args)
    return RPG::EventCommand.new(405, @indent,
                                          [args["value"].gsub(/^_/) { "" }])
  end
  #--------------------------------------------------------------------------
  # ○ 文章スクロール表示（終了部）
  #--------------------------------------------------------------------------
  def convert_scroll_end(args)
    @scroll = false
    return nil
  end
  
#****************************************************************************
# ゲーム進行系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ スイッチの操作
  #--------------------------------------------------------------------------
  def convert_sw(args)
    s_num = args["id"].to_i
    e_num = (args["end"] || s_num).to_i
    flag = args["flag"] == "on" ? 0 : 1
    return RPG::EventCommand.new(121, @indent, [s_num, e_num, flag])
  end
  #--------------------------------------------------------------------------
  # ○ 演算子の取得
  #--------------------------------------------------------------------------
  def get_operator(op)
    case op
    when "eq"
      op = 0
    when "+"
      op = 1
    when "-"
      op = 2
    when "*"
      op = 3
    when "/"
      op = 4
    when "%"
      op = 5
    else
      op = 0
    end
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（一般）
  #--------------------------------------------------------------------------
  def convert_var(args)
    s_num = args["id"].to_i
    e_num = (args["end"] || s_num).to_i
    op    = get_operator(args["op"])
    value   = args["value"]
    type    = value.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    if type == 1 and value.to_i <= 0
      raise(TesConvertError, "変数指定時に「0」以下が使われました。")
    end
    return RPG::EventCommand.new(122, @indent,
    [s_num, e_num, op, type, value.to_i])
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（ランダム）
  #--------------------------------------------------------------------------
  def convert_var_random(args)
    s_num = args["id"].to_i
    e_num = (args["end"] || s_num).to_i
    op    = get_operator(args["op"])
    min   = args["min"].to_i
    max   = args["max"].to_i
    return RPG::EventCommand.new(122, @indent,
    [s_num, e_num, op, 2, min, max])
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（アイテム）
  #--------------------------------------------------------------------------
  def convert_var_item(args)
    s_num = args["id"].to_i
    e_num = (args["end"] || s_num).to_i
    op    = get_operator(args["op"])
    value = args["value"].to_i
    return RPG::EventCommand.new(122, @indent,
    [s_num, e_num, op, 3, 0, value, 0])
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（武器）
  #--------------------------------------------------------------------------
  def convert_var_weapon(args)
    s_num = args["id"].to_i
    e_num = (args["end"] || s_num).to_i
    op    = get_operator(args["op"])
    value = args["value"].to_i
    return RPG::EventCommand.new(122, @indent,
    [s_num, e_num, op, 3, 1, value, 0])
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（防具）
  #--------------------------------------------------------------------------
  def convert_var_armor(args)
    s_num = args["id"].to_i
    e_num = (args["end"] || s_num).to_i
    op    = get_operator(args["op"])
    value = args["value"].to_i
    return RPG::EventCommand.new(122, @indent,
    [s_num, e_num, op, 3, 2, value, 0])
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（アクター）
  #--------------------------------------------------------------------------
  def convert_var_actor(args)
    s_num = args["id"].to_i
    e_num = (args["end"] || s_num).to_i
    op    = get_operator(args["op"])
    actor = args["actor"].to_i
    case args["data"]
    when "0", "level"
      data = 0
    when "1", "exp"
      data = 1
    when "2", "hp"
      data = 2
    when "3", "mp"
      data = 3
    when "4", "maxhp"
      data = 4
    when "5", "maxmp"
      data = 5
    when "6", "atk"
      data = 6
    when "7", "def"
      data = 7
    when "8", "matk"
      data = 8
    when "9", "mdef"
      data = 9
    when "10", "agi"
      data = 10
    when "11", "luk"
      data = 11
    end
    return RPG::EventCommand.new(122, @indent,
    [s_num, e_num, op, 3, 3, actor, data])
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（敵キャラ）
  #--------------------------------------------------------------------------
  def convert_var_enemy(args)
    s_num = args["id"].to_i
    e_num = (args["end"] || s_num).to_i
    op    = get_operator(args["op"])
    enemy = args["enemy"].to_i
    case args["data"]
    when "0", "hp"
      data = 0
    when "1", "mp"
      data = 1
    when "2", "maxhp"
      data = 2
    when "3", "maxmp"
      data = 3
    when "4", "atk"
      data = 4
    when "5", "def"
      data = 5
    when "6", "matk"
      data = 6
    when "7", "mdef"
      data = 7
    when "8", "agi"
      data = 8
    when "9", "luk"
      data = 9
    end
    return RPG::EventCommand.new(122, @indent,
    [s_num, e_num, op, 3, 4, enemy, data])
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（キャラクター）
  #--------------------------------------------------------------------------
  def convert_var_character(args)
    s_num = args["id"].to_i
    e_num = (args["end"] || s_num).to_i
    op    = get_operator(args["op"])
    character = args["character"].to_i
    case args["data"]
    when "0", "mapx"
      data = 0
    when "1", "mapy"
      data = 1
    when "2", "direction"
      data = 2
    when "3", "screenx"
      data = 3
    when "4", "screeny"
      data = 4
    end
    return RPG::EventCommand.new(122, @indent,
    [s_num, e_num, op, 3, 5, character, data])
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（パーティ）
  #--------------------------------------------------------------------------
  def convert_var_party(args)
    s_num = args["id"].to_i
    e_num = (args["end"] || s_num).to_i
    op    = get_operator(args["op"])
    member = args["member"].to_i
    return RPG::EventCommand.new(122, @indent,
    [s_num, e_num, op, 3, 6, member, 0])
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（その他）
  #--------------------------------------------------------------------------
  def convert_var_other(args)
    s_num = args["id"].to_i
    e_num = (args["end"] || s_num).to_i
    op    = get_operator(args["op"])
    case args["data"]
    when "0", "mapid"
      data = 0
    when "1", "members"
      data = 1
    when "2", "money"
      data = 2
    when "3", "steps"
      data = 3
    when "4", "playtime"
      data = 4
    when "5", "timer"
      data = 5
    when "6", "save_num"
      data = 6
    when "7", "battle_num"
      data = 7
    end
    return RPG::EventCommand.new(122, @indent,
    [s_num, e_num, op, 3, 7, data, 0])
  end
  #--------------------------------------------------------------------------
  # ○ 変数の操作（スクリプト）
  #--------------------------------------------------------------------------
  def convert_var_script(args)
    s_num = args["id"].to_i
    e_num = (args["end"] || s_num).to_i
    op    = get_operator(args["op"])
    script = args["script"].gsub(/<!!>/) {"="}
    script.gsub!(/<ii>/) {" "}
    return RPG::EventCommand.new(122, @indent,
    [s_num, e_num, op, 4, script])
  end
  #--------------------------------------------------------------------------
  # ○ セルフスイッチの操作
  #--------------------------------------------------------------------------
  def convert_self_sw(args)
    id = args["id"]
    flag = args["flag"] == "on" ? 0 : 1
    return RPG::EventCommand.new(123, @indent, [id, flag])
  end
  #--------------------------------------------------------------------------
  # ○ タイマーの操作
  #--------------------------------------------------------------------------
  def convert_timer(args)
    flag = args["flag"] == "on" ? 0 : 1
    if flag == 0
      unless args["time"]
        raise(TesConvertError, "[time] : 必須引数が省略されています。")
      end
      time = args["time"].to_i
    end
    return RPG::EventCommand.new(124, @indent, [flag, time])
  end
  
#****************************************************************************
# フロー制御系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ 条件分岐（スイッチ）
  #--------------------------------------------------------------------------
  def convert_if_sw(args)
    @indent += 1
    ifnum = 0
    id    = args["id"].to_i
    flag  = (args["flag"] || "on") == "on" ? 0 : 1
    return RPG::EventCommand.new(111, @indent - 1, [ifnum, id, flag])
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（変数）
  #--------------------------------------------------------------------------
  def convert_if_var(args)
    @indent += 1
    ifnum = 1
    id    = args["id"].to_i
    value = args["value"]
    type  = value.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    op    = ["eq", "ge", "le", "gt", "lt", "ne"].index(args["op"]) || 0
    op    = 0 unless op
    if type == 1 and value.to_i <= 0
      raise(TesConvertError, "変数指定時に「0」以下が使われました。")
    end
    return RPG::EventCommand.new(111, @indent - 1,
    [ifnum, id, type, value.to_i, op])
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（セルフスイッチ）
  #--------------------------------------------------------------------------
  def convert_if_self_sw(args)
    @indent += 1
    ifnum = 2
    id    = args["id"]
    flag  = (args["flag"] || "on") == "on" ? 0 : 1
    return RPG::EventCommand.new(111, @indent - 1, [ifnum, id, flag])
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（タイマー）
  #--------------------------------------------------------------------------
  def convert_if_timer(args)
    @indent += 1
    ifnum = 3
    time  = args["time"].to_i
    op    = ["ge", "le"].index(args["op"]) || 0
    return RPG::EventCommand.new(111, @indent - 1, [ifnum, time, op])
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（アクター）
  #--------------------------------------------------------------------------
  def convert_if_actor(args)
    @indent += 1
    ifnum = 4
    id = args["id"].to_i
    case args["type"]
    when "party"
      type  = 0
      value = 0
    when "name"
      type  = 1
      value = args["value"]
    when "class"
      type  = 2
      check_notEmpty(args, "value")
      check_numeric(args, "value", 1, nil)
      value = args["value"].to_i
    when "skill"
      type  = 3
      check_notEmpty(args, "value")
      check_numeric(args, "value", 1, nil)
      value = args["value"].to_i
    when "weapon"
      type  = 4
      check_notEmpty(args, "value")
      check_numeric(args, "value", 1, nil)
      value = args["value"].to_i
    when "armor"
      type  = 5
      check_notEmpty(args, "value")
      check_numeric(args, "value", 1, nil)
      value = args["value"].to_i
    when "state"
      type  = 6
      check_notEmpty(args, "value")
      check_numeric(args, "value", 1, nil)
      value = args["value"].to_i
    else
      type  = 0
      value = 0
    end
    return RPG::EventCommand.new(111, @indent - 1, [ifnum, id, type, value])
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（敵キャラ）
  #--------------------------------------------------------------------------
  def convert_if_enemy(args)
    @indent += 1
    ifnum = 5
    enemy = args["enemy"].to_i
    case args["type"]
    when "visible"
      type  = 0
      value = 0
    when "state"
      type  = 1
      check_notEmpty(args, "value")
      check_numeric(args, "value", 1, nil)
      value = args["value"].to_i
    else
      type  = 0
      value = 0
    end
    return RPG::EventCommand.new(111, @indent - 1, [ifnum, enemy, type, value])
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（キャラクター）
  #--------------------------------------------------------------------------
  def convert_if_character(args)
    @indent += 1
    ifnum = 6
    id = args["id"].to_i
    case args["direction"]
    when "2", "down"
      direction = 2
    when "4", "left"
      direction = 4
    when "6", "right"
      direction = 6
    when "8", "up"
      direction = 8
    end
    return RPG::EventCommand.new(111, @indent - 1, [ifnum, id, direction])
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（乗り物）
  #--------------------------------------------------------------------------
  def convert_if_vehicle(args)
    @indent += 1
    ifnum = 13
    vehicle = args["vehicle"].to_i
    return RPG::EventCommand.new(111, @indent - 1, [ifnum, vehicle])
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（お金）
  #--------------------------------------------------------------------------
  def convert_if_money(args)
    @indent += 1
    ifnum = 7
    money = args["money"].to_i
    op    = ["ge", "le", "lt"].index(args["op"]) || 0
    return RPG::EventCommand.new(111, @indent - 1, [ifnum, money, op])
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（アイテム）
  #--------------------------------------------------------------------------
  def convert_if_item(args)
    @indent += 1
    ifnum = 8
    id    = args["id"].to_i
    return RPG::EventCommand.new(111, @indent - 1, [ifnum, id])
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（武器）
  #--------------------------------------------------------------------------
  def convert_if_weapon(args)
    @indent += 1
    ifnum = 9
    id    = args["id"].to_i
    equip = (args["equip"] || "false") == "true" ? true : false
    return RPG::EventCommand.new(111, @indent - 1, [ifnum, id, equip])
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（防具）
  #--------------------------------------------------------------------------
  def convert_if_armor(args)
    @indent += 1
    ifnum = 10
    id    = args["id"].to_i
    equip = (args["equip"] || "false") == "true" ? true : false
    return RPG::EventCommand.new(111, @indent - 1, [ifnum, id, equip])
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（ボタン）
  #--------------------------------------------------------------------------
  def convert_if_button(args)
    @indent += 1
    ifnum = 11
    case args["button"]
    when "2", "down"
      button = 2
    when "4", "left"
      button = 4
    when "6", "right"
      button = 6
    when "8", "up"
      button = 8
    when "11", "A"
      button = 11
    when "12", "B"
      button = 12
    when "13", "C"
      button = 13
    when "14", "X"
      button = 14
    when "15", "Y"
      button = 15
    when "16", "Z"
      button = 16
    when "17", "L"
      button = 17
    when "18", "R"
      button = 18
    end
    return RPG::EventCommand.new(111, @indent - 1, [ifnum, button])
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（スクリプト）
  #--------------------------------------------------------------------------
  def convert_if_script(args)
    @indent += 1
    ifnum = 12
    script = args["script"].gsub(/<!!>/) {"="}
    script.gsub!(/<ii>/) {" "}
    return RPG::EventCommand.new(111, @indent - 1, [ifnum, script])
  end
  #--------------------------------------------------------------------------
  # ○ 条件分岐（それ以外）
  #--------------------------------------------------------------------------
  def convert_else(args)
    @indent += 1
    return RPG::EventCommand.new(411, @indent - 1, [])
  end
  #--------------------------------------------------------------------------
  # ○ ループ
  #--------------------------------------------------------------------------
  def convert_loop(args)
    @indent += 1
    return RPG::EventCommand.new(112, @indent - 1, [])
  end
  #--------------------------------------------------------------------------
  # ○ ループの終わり
  #--------------------------------------------------------------------------
  def convert_loop_end(args)
    @indent -= 1
    return RPG::EventCommand.new(413, @indent, [])
  end
  #--------------------------------------------------------------------------
  # ○ ループの中断
  #--------------------------------------------------------------------------
  def convert_loop_break(args)
    return RPG::EventCommand.new(113, @indent, [])
  end
  #--------------------------------------------------------------------------
  # ○ イベントの中断
  #--------------------------------------------------------------------------
  def convert_event_break(args)
    return RPG::EventCommand.new(115, @indent, [])
  end
  #--------------------------------------------------------------------------
  # ○ イベントの中断（returnタグにて）
  #--------------------------------------------------------------------------
  def convert_return(args)
    return RPG::EventCommand.new(115, @indent, [])
  end
  #--------------------------------------------------------------------------
  # ○ コモンイベント
  #--------------------------------------------------------------------------
  def convert_common(args)
    return RPG::EventCommand.new(117, @indent, [args["id"].to_i])
  end
  #--------------------------------------------------------------------------
  # ○ ラベル
  #--------------------------------------------------------------------------
  def convert_label(args)
    return RPG::EventCommand.new(118, @indent, [args["value"]])
  end
  #--------------------------------------------------------------------------
  # ○ ラベルジャンプ
  #--------------------------------------------------------------------------
  def convert_label_jump(args)
    return RPG::EventCommand.new(119, @indent, [args["value"]])
  end
  #--------------------------------------------------------------------------
  # ○ 注釈
  #--------------------------------------------------------------------------
  def convert_comment(args)
    return RPG::EventCommand.new(108, @indent, [args["value"]])
  end
  #--------------------------------------------------------------------------
  # ○ 注釈（２行目以降）
  #--------------------------------------------------------------------------
  def convert_comment2(args)
    return RPG::EventCommand.new(408, @indent, [args["value"]])
  end
  
#****************************************************************************
# パーティ系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ 所持金の増減
  #--------------------------------------------------------------------------
  def convert_money(args)
    value   = args["value"]
    type    = value.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    operate = value.gsub!(/(^-)/)   { "" } ? 1 : 0	#0:加算 1:減算
    return RPG::EventCommand.new(125, @indent, [operate, type, value.to_i])
  end
  #--------------------------------------------------------------------------
  # ○ アイテムの増減
  #--------------------------------------------------------------------------
  def convert_item(args)
    id      = args["id"].to_i
    value   = args["value"]
    type    = value.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    operate = value.gsub!(/(^-)/)   { "" } ? 1 : 0	#0:加算 1:減算
    return RPG::EventCommand.new(126, @indent,
                                             [id, operate, type, value.to_i])
  end
  #--------------------------------------------------------------------------
  # ○ 武器の増減
  #--------------------------------------------------------------------------
  def convert_weapon(args)
    id      = args["id"].to_i
    value   = args["value"]
    type    = value.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    operate = value.gsub!(/(^-)/)   { "" } ? 1 : 0	#0:加算 1:減算
    equip   = (args["equip"] || "false") == "true" ? true : false
    return RPG::EventCommand.new(127, @indent,
                                      [id, operate, type, value.to_i, equip])
  end
  #--------------------------------------------------------------------------
  # ○ 防具の増減
  #--------------------------------------------------------------------------
  def convert_armor(args)
    id      = args["id"].to_i
    value   = args["value"]
    type    = value.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    operate = value.gsub!(/(^-)/)   { "" } ? 1 : 0	#0:加算 1:減算
    equip   = (args["equip"] || "false") == "true" ? true : false
    return RPG::EventCommand.new(128, @indent,
                                      [id, operate, type, value.to_i, equip])
  end
  #--------------------------------------------------------------------------
  # ○ メンバーの入れ替え
  #--------------------------------------------------------------------------
  def convert_member(args)
    id      = args["id"]
    operate = id.gsub!(/(^-)/) { "" } ? 1 : 0	#0:加算 1:減算
    init    = (args["init"] || "false") == "true" ? 1 : 0
    return RPG::EventCommand.new(129, @indent, [id.to_i, operate, init])
  end
  
#****************************************************************************
# アクター系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ ＨＰの増減
  #--------------------------------------------------------------------------
  def convert_hp(args)
    actor   = args["actor"]
    is_var  = actor.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    value   = args["value"]
    type    = value.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    operate = value.gsub!(/(^-)/)   { "" } ? 1 : 0	#0:加算 1:減算
    death   = (args["death"] || "false") == "true" ? true : false
    return RPG::EventCommand.new(311, @indent,
                      [is_var, actor.to_i, operate, type, value.to_i, death])
  end
  #--------------------------------------------------------------------------
  # ○ ＭＰの増減
  #--------------------------------------------------------------------------
  def convert_mp(args)
    actor   = args["actor"]
    is_var  = actor.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    value   = args["value"]
    type    = value.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    operate = value.gsub!(/(^-)/)   { "" } ? 1 : 0	#0:加算 1:減算
    return RPG::EventCommand.new(312, @indent,
                             [is_var, actor.to_i, operate, type, value.to_i])
  end
  #--------------------------------------------------------------------------
  # ○ ステートの変更
  #--------------------------------------------------------------------------
  def convert_state(args)
    actor   = args["actor"]
    is_var  = actor.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    value   = args["value"]
    operate = value.gsub!(/(^-)/)   { "" } ? 1 : 0	#0:加算 1:減算
    return RPG::EventCommand.new(313, @indent,
                                   [is_var, actor.to_i, operate, value.to_i])
  end
  #--------------------------------------------------------------------------
  # ○ 全回復
  #--------------------------------------------------------------------------
  def convert_all_recovery(args)
    actor   = args["actor"]
    is_var  = actor.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    return RPG::EventCommand.new(314, @indent, [is_var, actor.to_i])
  end
  #--------------------------------------------------------------------------
  # ○ 経験値の増減
  #--------------------------------------------------------------------------
  def convert_exp(args)
    actor   = args["actor"]
    is_var  = actor.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    value   = args["value"]
    type    = value.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    operate = value.gsub!(/(^-)/)   { "" } ? 1 : 0	#0:加算 1:減算
    message = (args["message"] || "false") == "true" ? true : false
    return RPG::EventCommand.new(315, @indent,
                    [is_var, actor.to_i, operate, type, value.to_i, message])
  end
  #--------------------------------------------------------------------------
  # ○ レベルの増減
  #--------------------------------------------------------------------------
  def convert_level(args)
    actor   = args["actor"]
    is_var  = actor.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    value   = args["value"]
    type    = value.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    operate = value.gsub!(/(^-)/)   { "" } ? 1 : 0	#0:加算 1:減算
    message = (args["message"] || "false") == "true" ? true : false
    return RPG::EventCommand.new(316, @indent,
                    [is_var, actor.to_i, operate, type, value.to_i, message])
  end
  #--------------------------------------------------------------------------
  # ○ 能力値の増減
  #--------------------------------------------------------------------------
  def convert_capability(args)
    actor   = args["actor"]
    is_var  = actor.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    case args["capability"]
    when "0", "maxhp"
      capability = 0
    when "1", "maxmp"
      capability = 1
    when "2", "atk"
      capability = 2
    when "3", "def"
      capability = 3
    when "4", "matk"
      capability = 4
    when "5", "mdef"
      capability = 5
    when "6", "agi"
      capability = 6
    when "7", "luk"
      capability = 7
    end
    value   = args["value"]
    type    = value.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    operate = value.gsub!(/(^-)/)   { "" } ? 1 : 0	#0:加算 1:減算
    return RPG::EventCommand.new(317, @indent,
                 [is_var, actor.to_i, capability, operate, type, value.to_i])
  end
  #--------------------------------------------------------------------------
  # ○ スキルの増減
  #--------------------------------------------------------------------------
  def convert_skill(args)
    actor   = args["actor"]
    is_var  = actor.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    value   = args["value"]
    operate = value.gsub!(/(^-)/)   { "" } ? 1 : 0	#0:加算 1:減算
    return RPG::EventCommand.new(318, @indent,
                                   [is_var, actor.to_i, operate, value.to_i])
  end
  #--------------------------------------------------------------------------
  # ○ 装備の変更
  #--------------------------------------------------------------------------
  def convert_equip(args)
    actor    = args["actor"].to_i
    part     = args["part"].to_i
    id       = args["id"].to_i
    return RPG::EventCommand.new(319, @indent, [actor, part, id])
  end
  #--------------------------------------------------------------------------
  # ○ 名前の変更
  #--------------------------------------------------------------------------
  def convert_name(args)
    actor    = args["actor"].to_i
    value    = args["value"]
    return RPG::EventCommand.new(320, @indent, [actor, value])
  end
  #--------------------------------------------------------------------------
  # ○ 職業の変更
  #--------------------------------------------------------------------------
  def convert_class(args)
    actor    = args["actor"].to_i
    value    = args["value"].to_i
    return RPG::EventCommand.new(321, @indent, [actor, value])
  end
  #--------------------------------------------------------------------------
  # ○ 二つ名の変更
  #--------------------------------------------------------------------------
  def convert_nickname(args)
    actor    = args["actor"].to_i
    value    = args["value"]
    return RPG::EventCommand.new(324, @indent, [actor, value])
  end
  
#****************************************************************************
# 移動系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ 場所移動
  #--------------------------------------------------------------------------
  def convert_map_move(args)
    type      = (args["type"] || "const") == "const" ? 0 : 1
    map       = args["map"].to_i
    x         = args["x"].to_i
    y         = args["y"].to_i
    case args["direction"]
    when "2", "down"
      direction = 2
    when "4", "left"
      direction = 4
    when "6", "right"
      direction = 6
    when "8", "up"
      direction = 8
    else
      direction = 0
    end
    case args["fade"]
    when "1", "white"
      fade = 1
    when "2", "none"
      fade = 2
    else
      fade = 0
    end
    return RPG::EventCommand.new(201, @indent,
                                          [type, map, x, y, direction, fade])
  end
  #--------------------------------------------------------------------------
  # ○ 乗り物の位置設定
  #--------------------------------------------------------------------------
  def convert_vehicle_pos(args)
    vehicle = args["vehicle"].to_i
    type    = (args["type"] || "const") == "const" ? 0 : 1
    map     = args["map"].to_i
    x       = args["x"].to_i
    y       = args["y"].to_i
    return RPG::EventCommand.new(202, @indent, [vehicle, type, map, x, y])
  end
  #--------------------------------------------------------------------------
  # ○ イベントの位置設定
  #--------------------------------------------------------------------------
  def convert_event_pos(args)
    id        = args["id"].to_i
    type      = 1 if args["type"] == "var"
    type      = 2 if args["type"] == "target"
    type      = 0 unless type
    x         = args["x"].to_i
    y         = args["y"].to_i
    case args["direction"]
    when "2", "down"
      direction = 2
    when "4", "left"
      direction = 4
    when "6", "right"
      direction = 6
    when "8", "up"
      direction = 8
    else
      direction = 0
    end
    return RPG::EventCommand.new(203, @indent, [id, type, x, y, direction])
  end
  #--------------------------------------------------------------------------
  # ○ マップのスクロール
  #--------------------------------------------------------------------------
  def convert_scroll_map(args)
    case args["direction"]
    when "2", "down"
      direction = 2
    when "4", "left"
      direction = 4
    when "6", "right"
      direction = 6
    when "8", "up"
      direction = 8
    end
    num       = args["num"].to_i
    speed     = (args["speed"] || 4).to_i
    return RPG::EventCommand.new(204, @indent, [direction, num, speed])
  end
  #--------------------------------------------------------------------------
  # ○ 移動ルートの設定（ヘッダー部）
  #--------------------------------------------------------------------------
  def convert_route_h(args)
    event = args["event"].to_i
    temp = RPG::MoveRoute.new
    temp.repeat      = (args["repeat"] || "false") == "true" ? true : false
    temp.skippable   = (args["skip"]   || "false") == "true" ? true : false
    temp.wait        = (args["wait"]   || "false") == "true" ? true : false
    temp.repeat      = false if temp.repeat and temp.wait  # 同時true防止
    return RPG::EventCommand.new(205, @indent, [event, temp])
  end
  #--------------------------------------------------------------------------
  # ○ 移動ルートの設定（移動方法）
  #--------------------------------------------------------------------------
  def convert_route(args)
    param = []
    case args["type"]
    when "1", "down"
      type = 1
    when "2", "left"
      type = 2
    when "3", "right"
      type = 3
    when "4", "up"
      type = 4
    when "5", "dl"
      type = 5
    when "6", "dr"
      type = 6
    when "7", "ul"
      type = 7
    when "8", "ur"
      type = 8
    when "9", "random"
      type = 9
    when "10", "toward"
      type = 10
    when "11", "away"
      type = 11
    when "12", "foward"
      type = 12
    when "13", "backward"
      type = 13
    when "14", "jump"
      type = 14
      check_numeric(args, "x", -100, 100)
      check_numeric(args, "y", -100, 100)
      param[0] = (args["x"] || 0).to_i
      param[1] = (args["y"] || 0).to_i
    when "15", "wait"
      type = 15
      check_numeric(args, "time", 1, 999)
      param[0] = (args["time"] || 60).to_i
    when "16", "turn_down"
      type = 16
    when "17", "turn_left"
      type = 17
    when "18", "turn_right"
      type = 18
    when "19", "turn_up"
      type = 19
    when "20", "turn_90_r"
      type = 20
    when "21", "turn_90_l"
      type = 21
    when "22", "turn_180"
      type = 22
    when "23", "turn_90_rl", "turn_90_lr"
      type = 23
    when "24", "turn_random"
      type = 24
    when "25", "turn_toward"
      type = 25
    when "26", "turn_away"
      type = 26
    when "27", "switch_on", "sw_on"
      type = 27
      check_notEmpty(args, "id")
      check_numeric(args, "id", 1, nil)
      param[0] = args["id"].to_i
    when "28", "switch_off", "sw_off"
      type = 28
      check_notEmpty(args, "id")
      check_numeric(args, "id", 1, nil)
      param[0] = args["id"].to_i
    when "29", "change_speed"
      type = 29
      check_numeric(args, "speed", 1, 6)
      param[0] = (args["speed"] || 3).to_i
    when "30", "change_freq"
      type = 30
      check_numeric(args, "freq", 1, 5)
      param[0] = (args["freq"] || 3).to_i
    when "31", "walk_anime_on"
      type = 31
    when "32", "walk_anime_off"
      type = 32
    when "33", "step_anime_on"
      type = 33
    when "34", "step_anime_off"
      type = 34
    when "35", "dir_fix_on"
      type = 35
    when "36", "dir_fix_off"
      type = 36
    when "37", "through_on"
      type = 37
    when "38", "through_off"
      type = 38
    when "39", "transparent_on"
      type = 39
    when "40", "transparent_off"
      type = 40
    when "41", "change_graphic"
      type = 41
      check_notEmpty(args, "file")
      check_notEmpty(args, "index")
      check_numeric(args, "index", 0, 7)
      param[0] = args["file"]
      param[1] = args["index"].to_i
    when "42", "change_opacity"
      type = 42
      check_numeric(args, "opacity", 0, 255)
      param[0] = (args["opacity"] || 255).to_i
    when "43", "change_blend"
      type = 43
      check_numeric(args, "blend", 0, 2)
      param[0] = (args["blend"] || 0).to_i
    when "44", "play_se"
      type = 44
      check_numeric(args, "volume", 0, 100)
      check_numeric(args, "pitch", 50, 150)
      file   = (args["file"]   || "")
      volume = (args["volume"] || 100).to_i
      pitch  = (args["pitch"]  || 100).to_i
      param = [RPG::SE.new(file, volume, pitch)]
    when "45", "script"
      type = 45
      check_notEmpty(args, "script")
      args["script"].gsub!(/<!!>/) { "=" }
      args["script"].gsub!(/<ii>/) { " " }
      param[0] = args["script"]
    else
      raise(TesConvertError, "存在しない移動コマンドです。")
    end
    return RPG::EventCommand.new(505, @indent, 
                                         [RPG::MoveCommand.new(type, param)])
  end
  #--------------------------------------------------------------------------
  # ○ 乗り物の乗降
  #--------------------------------------------------------------------------
  def convert_vehicle(args)
    return RPG::EventCommand.new(206, @indent, [])
  end
  
#****************************************************************************
# キャラクター系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ 透明状態の変更
  #--------------------------------------------------------------------------
  def convert_transparent(args)
    flag = args["flag"] == "on" ? 0 : 1
    return RPG::EventCommand.new(211, @indent, [flag])
  end
  #--------------------------------------------------------------------------
  # ○ 隊列歩行の変更
  #--------------------------------------------------------------------------
  def convert_followers(args)
    flag = args["flag"] == "on" ? 0 : 1
    return RPG::EventCommand.new(216, @indent, [flag])
  end
  #--------------------------------------------------------------------------
  # ○ 隊列メンバーの集合
  #--------------------------------------------------------------------------
  def convert_gather(args)
    return RPG::EventCommand.new(217, @indent, [])
  end
  #--------------------------------------------------------------------------
  # ○ アニメーションの表示
  #--------------------------------------------------------------------------
  def convert_anime(args)
    target  = args["target"].to_i
    anime   = args["anime"].to_i
    wait    = (args["wait"] || "false") == "true" ? true : false
    return RPG::EventCommand.new(212, @indent, [target, anime, wait])
  end
  #--------------------------------------------------------------------------
  # ○ フキダシアイコンの表示
  #--------------------------------------------------------------------------
  def convert_balloon(args)
    target  = args["target"].to_i
    balloon = args["balloon"].to_i
    wait    = (args["wait"] || "false") == "true" ? true : false
    return RPG::EventCommand.new(213, @indent, [target, balloon, wait])
  end
  #--------------------------------------------------------------------------
  # ○ イベントの一時消去
  #--------------------------------------------------------------------------
  def convert_erace(args)
    return RPG::EventCommand.new(214, @indent, [])
  end
  
#****************************************************************************
# 画面効果系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ 画面のフェードアウト
  #--------------------------------------------------------------------------
  def convert_fadeout(args)
    return RPG::EventCommand.new(221, @indent, [])
  end
  #--------------------------------------------------------------------------
  # ○ 画面のフェードイン
  #--------------------------------------------------------------------------
  def convert_fadein(args)
    return RPG::EventCommand.new(222, @indent, [])
  end
  #--------------------------------------------------------------------------
  # ○ 画面の色調変更
  #--------------------------------------------------------------------------
  def convert_tone(args)
    red   = (args["red"]   || 0.0).to_f
    green = (args["green"] || 0.0).to_f
    blue  = (args["blue"]  || 0.0).to_f
    gray  = (args["gray"]  || 0.0).to_f
    tone  = Tone.new(red, green, blue, gray)
    time  = (args["time"]  || 60).to_i
    wait  = (args["wait"]  || "true") == "true" ? true : false
    return RPG::EventCommand.new(223, @indent, [tone, time, wait])
  end
  #--------------------------------------------------------------------------
  # ○ 画面のフラッシュ
  #--------------------------------------------------------------------------
  def convert_flash(args)
    red      = (args["red"]       || 255.0).to_f
    green    = (args["green"]     || 255.0).to_f
    blue     = (args["blue"]      || 255.0).to_f
    strength = (args["strength"]  || 255.0).to_f
    color    = Color.new(red, green, blue, strength)
    time     = (args["time"] || 60).to_i
    wait     = (args["wait"] || "true") == "true" ? true : false
    return RPG::EventCommand.new(224, @indent, [color, time, wait])
  end
  #--------------------------------------------------------------------------
  # ○ 画面のシェイク
  #--------------------------------------------------------------------------
  def convert_shake(args)
    strength = (args["strength"] || 5).to_i
    speed    = (args["speed"]    || 5).to_i
    time     = (args["time"] || 60).to_i
    wait     = (args["wait"] || "true") == "true" ? true : false
    return RPG::EventCommand.new(225, @indent, [strength, speed, time, wait])
  end
  
#****************************************************************************
# 時間調整系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ ウェイト
  #--------------------------------------------------------------------------
  def convert_wait(args)
    time  = (args["time"] || 60).to_i
    return RPG::EventCommand.new(230, @indent, [time])
  end
  
#****************************************************************************
# ピクチャと天候系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ ピクチャの表示
  #--------------------------------------------------------------------------
  def convert_picture(args)
    layer       = args["layer"].to_i
    file        = args["file"]
    origin      = (args["origin"] || "ul")    == "ul"    ? 0 : 1
    type        = (args["type"]   || "const") == "const" ? 0 : 1
    x           = args["x"].to_i
    y           = args["y"].to_i
    zoom_x      = (args["zoom_x"] || 100).to_i
    zoom_y      = (args["zoom_y"] || 100).to_i
    transparent = (args["transparent"] || 255).to_i
    blend       = (args["blend"]       ||   0).to_i
    return RPG::EventCommand.new(231, @indent,
       [layer, file, origin, type, x, y, zoom_x, zoom_y, transparent, blend])
  end
  #--------------------------------------------------------------------------
  # ○ ピクチャの移動
  #--------------------------------------------------------------------------
  def convert_picture_move(args)
    layer       = args["layer"].to_i
    file        = nil
    origin      = (args["origin"] || "ul")    == "ul"    ? 0 : 1
    type        = (args["type"]   || "const") == "const" ? 0 : 1
    x           = args["x"].to_i
    y           = args["y"].to_i
    zoom_x      = (args["zoom_x"] || 100).to_i
    zoom_y      = (args["zoom_y"] || 100).to_i
    transparent = (args["transparent"] || 255).to_i
    blend       = (args["blend"]       ||   0).to_i
    time        = (args["time"] || 60).to_i
    wait        = (args["wait"] || "true") == "true" ? true : false
    return RPG::EventCommand.new(232, @indent, [layer, nil,
         origin, type, x, y, zoom_x, zoom_y, transparent, blend, time, wait])
  end
  #--------------------------------------------------------------------------
  # ○ ピクチャの回転
  #--------------------------------------------------------------------------
  def convert_picture_rotation(args)
    layer  = args["layer"].to_i
    speed  = (args["speed"] || 5).to_i
    return RPG::EventCommand.new(233, @indent, [layer, speed])
  end
  #--------------------------------------------------------------------------
  # ○ ピクチャの色調変更
  #--------------------------------------------------------------------------
  def convert_picture_tone(args)
    layer = args["layer"].to_i
    red   = (args["red"]   || 0.0).to_f
    green = (args["green"] || 0.0).to_f
    blue  = (args["blue"]  || 0.0).to_f
    gray  = (args["gray"]  || 0.0).to_f
    tone  = Tone.new(red, green, blue, gray)
    time  = (args["time"] || 60).to_i
    wait  = (args["wait"] || "true") == "true" ? true : false
    return RPG::EventCommand.new(234, @indent, [layer, tone, time, wait])
  end
  #--------------------------------------------------------------------------
  # ○ ピクチャの消去
  #--------------------------------------------------------------------------
  def convert_picture_erace(args)
    layer  = args["layer"].to_i
    return RPG::EventCommand.new(235, @indent, [layer])
  end
  #--------------------------------------------------------------------------
  # ○ 天候の設定
  #--------------------------------------------------------------------------
  def convert_weather(args)
    weather = (args["weather"] || "none").to_sym
    strength = (args["strength"] || 5).to_i
    time     = (args["time"] || 60).to_i
    wait     = (args["wait"] || "true") == "true" ? true : false
    return RPG::EventCommand.new(236, @indent,
                                             [weather, strength, time, wait])
  end
  
#****************************************************************************
# 音楽と効果音系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ ＢＧＭの演奏
  #--------------------------------------------------------------------------
  def convert_bgm(args)
    file   = (args["file"] || "")
    volume = (args["volume"] || 100).to_i
    pitch  = (args["pitch"]  || 100).to_i
    temp = RPG::BGM.new(file, volume, pitch)
    return RPG::EventCommand.new(241, @indent, [temp])
  end
  #--------------------------------------------------------------------------
  # ○ ＢＧＭのフェードアウト
  #--------------------------------------------------------------------------
  def convert_fadeout_bgm(args)
    time = (args["time"] || 10).to_i
    return RPG::EventCommand.new(242, @indent, [time])
  end
  #--------------------------------------------------------------------------
  # ○ ＢＧＭの保存
  #--------------------------------------------------------------------------
  def convert_save_bgm(args)
    return RPG::EventCommand.new(243, @indent, [])
  end
  #--------------------------------------------------------------------------
  # ○ ＢＧＭの再開
  #--------------------------------------------------------------------------
  def convert_resume_bgm(args)
    return RPG::EventCommand.new(244, @indent, [])
  end
  #--------------------------------------------------------------------------
  # ○ ＢＧＳの演奏
  #--------------------------------------------------------------------------
  def convert_bgs(args)
    file   = (args["file"] || "")
    volume = (args["volume"] || 100).to_i
    pitch  = (args["pitch"]  || 100).to_i
    temp = RPG::BGS.new(file, volume, pitch)
    return RPG::EventCommand.new(245, @indent, [temp])
  end
  #--------------------------------------------------------------------------
  # ○ ＢＧＳのフェードアウト
  #--------------------------------------------------------------------------
  def convert_fadeout_bgs(args)
    time = (args["time"] || 10).to_i
    return RPG::EventCommand.new(246, @indent, [time])
  end
  #--------------------------------------------------------------------------
  # ○ ＭＥの演奏
  #--------------------------------------------------------------------------
  def convert_me(args)
    file   = (args["file"] || "")
    volume = (args["volume"] || 100).to_i
    pitch  = (args["pitch"]  || 100).to_i
    temp = RPG::ME.new(file, volume, pitch)
    return RPG::EventCommand.new(249, @indent, [temp])
  end
  #--------------------------------------------------------------------------
  # ○ ＳＥの演奏
  #--------------------------------------------------------------------------
  def convert_se(args)
    file   = (args["file"] || "")
    volume = (args["volume"] ||  80).to_i
    pitch  = (args["pitch"]  || 100).to_i
    temp = RPG::SE.new(file, volume, pitch)
    return RPG::EventCommand.new(250, @indent, [temp])
  end
  #--------------------------------------------------------------------------
  # ○ ＳＥの停止
  #--------------------------------------------------------------------------
  def convert_stop_se(args)
    return RPG::EventCommand.new(251, @indent, [])
  end
  
#****************************************************************************
# シーン制御系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ バトルの処理（ヘッダー部）
  #--------------------------------------------------------------------------
  def convert_battle(args)
    id   = args["id"]
    type = id.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    id   = id.to_i
    type = 2 if id == 0
    escape   = (args["can_escape"]    || "false") == "true" ? true : false
    continue = (args["loss_continue"] || "false") == "true" ? true : false
    return RPG::EventCommand.new(301, @indent,
                                                [type, id, escape, continue])
  end
  #--------------------------------------------------------------------------
  # ○ バトルの処理（勝った場合）
  #--------------------------------------------------------------------------
  def convert_battle_win(args)
    @indent += 1
    return RPG::EventCommand.new(601, @indent - 1, [])
  end
  #--------------------------------------------------------------------------
  # ○ バトルの処理（逃げた場合）
  #--------------------------------------------------------------------------
  def convert_battle_escape(args)
    @indent += 1
    return RPG::EventCommand.new(602, @indent - 1, [])
  end
  #--------------------------------------------------------------------------
  # ○ バトルの処理（負けた場合）
  #--------------------------------------------------------------------------
  def convert_battle_loss(args)
    @indent += 1
    return RPG::EventCommand.new(603, @indent - 1, [])
  end
  #--------------------------------------------------------------------------
  # ○ バトルの処理（分岐終了）
  #--------------------------------------------------------------------------
  def convert_battle_end(args)
    return RPG::EventCommand.new(604, @indent, [])
  end
  #--------------------------------------------------------------------------
  # ○ ショップの処理
  #--------------------------------------------------------------------------
  def convert_shop(args)
    type  = 0 if ["0", "item"].include?(args["type"])
    type  = 1 if ["1", "weapon"].include?(args["type"])
    type  = 2 if ["2", "armor"].include?(args["type"])
    id    = args["id"].to_i
    price = (args["price"] || "db") == "db" ? 0 : 1
    value = (args["value"] || 50).to_i
    buy_only = (args["buy_only"] || "false") == "true" ? true : false
    return RPG::EventCommand.new(605, @indent,
                                          [type, id, price, value, buy_only])
  end
  #--------------------------------------------------------------------------
  # ○ 名前入力の処理
  #--------------------------------------------------------------------------
  def convert_input_name(args)
    actor  = args["actor"].to_i
    number = (args["number"] || 6).to_i
    return RPG::EventCommand.new(303, @indent, [actor, number])
  end
  #--------------------------------------------------------------------------
  # ○ メニュー画面を開く
  #--------------------------------------------------------------------------
  def convert_menu_open(args)
    return RPG::EventCommand.new(351, @indent, [])
  end
  #--------------------------------------------------------------------------
  # ○ セーブ画面を開く
  #--------------------------------------------------------------------------
  def convert_save_open(args)
    return RPG::EventCommand.new(352, @indent, [])
  end
  #--------------------------------------------------------------------------
  # ○ ゲームオーバー
  #--------------------------------------------------------------------------
  def convert_gameover(args)
    return RPG::EventCommand.new(353, @indent, [])
  end
  #--------------------------------------------------------------------------
  # ○ タイトル画面に戻す
  #--------------------------------------------------------------------------
  def convert_title_return(args)
    return RPG::EventCommand.new(354, @indent, [])
  end
  
#****************************************************************************
# システム設定系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ 戦闘ＢＧＭの変更
  #--------------------------------------------------------------------------
  def convert_battle_bgm(args)
    file   = (args["file"] || "")
    volume = (args["volume"] || 100).to_i
    pitch  = (args["pitch"]  || 100).to_i
    temp = RPG::BGM.new(file, volume, pitch)
    return RPG::EventCommand.new(132, @indent, [temp])
  end
  #--------------------------------------------------------------------------
  # ○ 戦闘終了ＭＥの変更
  #--------------------------------------------------------------------------
  def convert_battle_end_me(args)
    file   = (args["file"] || "")
    volume = (args["volume"] || 100).to_i
    pitch  = (args["pitch"]  || 100).to_i
    temp = RPG::ME.new(file, volume, pitch)
    return RPG::EventCommand.new(133, @indent, [temp])
  end
  #--------------------------------------------------------------------------
  # ○ セーブ禁止の変更
  #--------------------------------------------------------------------------
  def convert_save_disable(args)
    flag = (args["flag"] || "true") == "true" ? 0 : 1
    return RPG::EventCommand.new(134, @indent, [flag])
  end
  #--------------------------------------------------------------------------
  # ○ メニュー禁止の変更
  #--------------------------------------------------------------------------
  def convert_menu_disable(args)
    flag = (args["flag"] || "true") == "true" ? 0 : 1
    return RPG::EventCommand.new(135, @indent, [flag])
  end
  #--------------------------------------------------------------------------
  # ○ エンカウント禁止の変更
  #--------------------------------------------------------------------------
  def convert_encount_disable(args)
    flag = (args["flag"] || "true") == "true" ? 0 : 1
    return RPG::EventCommand.new(136, @indent, [flag])
  end
  #--------------------------------------------------------------------------
  # ○ 並び替え禁止の変更
  #--------------------------------------------------------------------------
  def convert_formation_disable(args)
    flag = (args["flag"] || "true") == "true" ? 0 : 1
    return RPG::EventCommand.new(137, @indent, [flag])
  end
  #--------------------------------------------------------------------------
  # ○ ウィンドウカラーの変更
  #--------------------------------------------------------------------------
  def convert_window_color(args)
    red      = (args["red"]   || -34.0).to_i
    green    = (args["green"] ||   0.0).to_i
    blue     = (args["blue"]  ||  68.0).to_i
    color    = Color.new(red, green, blue)
    return RPG::EventCommand.new(138, @indent, [color])
  end
  #--------------------------------------------------------------------------
  # ○ アクターのグラフィック変更
  #--------------------------------------------------------------------------
  def convert_actor_graphic(args)
    actor      = args["actor"].to_i
    walk_file  = (args["walk_file"]  || "")
    walk_index = (args["walk_index"] ||  0).to_i
    face_file  = (args["face_file"]  || "")
    face_index = (args["face_index"] ||  0).to_i
    return RPG::EventCommand.new(322, @indent,
                       [actor, walk_file, walk_index, face_file, face_index])
  end
  #--------------------------------------------------------------------------
  # ○ 乗り物のグラフィック変更
  #--------------------------------------------------------------------------
  def convert_vehicle_graphic(args)
    type  = args["vehicle"].to_i
    file  = (args["file"]  || "")
    index = (args["index"] ||  0).to_i
    return RPG::EventCommand.new(323, @indent, [type, file, index])
  end
  
#****************************************************************************
# ムービー系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ ムービーの再生
  #--------------------------------------------------------------------------
  def convert_movie(args)
    file = args["file"]
    return RPG::EventCommand.new(261, @indent, [file])
  end
  
#****************************************************************************
# マップ系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ マップ名表示の変更
  #--------------------------------------------------------------------------
  def convert_map_name_disable(args)
    flag = (args["flag"] || "true") == "true" ? 0 : 1
    return RPG::EventCommand.new(281, @indent, [flag])
  end
  #--------------------------------------------------------------------------
  # ○ タイルセットの変更
  #--------------------------------------------------------------------------
  def convert_tileset(args)
    id = args["id"].to_i
    return RPG::EventCommand.new(282, @indent, [id])
  end
  #--------------------------------------------------------------------------
  # ○ 戦闘背景の変更
  #--------------------------------------------------------------------------
  def convert_battle_background(args)
    floor = (args["floor"] || "")
    wall  = (args["wall"]  || "")
    return RPG::EventCommand.new(283, @indent, [floor, wall])
  end
  #--------------------------------------------------------------------------
  # ○ 遠景の変更
  #--------------------------------------------------------------------------
  def convert_parallax(args)
    file = (args["file"] || "")
    loop_x   = (args["loop_x"] || "false") == "true" ? true : false
    loop_y   = (args["loop_y"] || "false") == "true" ? true : false
    scroll_x = loop_x ? (args["scroll_x"] || 0).to_i : 0
    scroll_y = loop_y ? (args["scroll_y"] || 0).to_i : 0
    return RPG::EventCommand.new(284, @indent,
                                  [file, loop_x, loop_y, scroll_x, scroll_y])
  end
  #--------------------------------------------------------------------------
  # ○ 指定位置の情報取得
  #--------------------------------------------------------------------------
  def convert_pos_info(args)
    var  = args["var"].to_i
    type = (args["type"] || 0).to_i
    pos  = (args["pos"]  || "const") == "const" ? 0 : 1
    x    = args["x"].to_i
    y    = args["y"].to_i
    return RPG::EventCommand.new(285, @indent, [var, type, pos, x, y])
  end
  
#****************************************************************************
# バトル系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ 敵キャラのＨＰ増減
  #--------------------------------------------------------------------------
  def convert_enemy_hp(args)
    enemy   = args["enemy"].to_i
    value   = args["value"]
    type    = value.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    operate = value.gsub!(/(^-)/)   { "" } ? 1 : 0	#0:加算 1:減算
    death  = (args["death"] || "false") == "true" ? true : false
    return RPG::EventCommand.new(331, @indent,
                                   [enemy, operate, type, value.to_i, death])
  end
  #--------------------------------------------------------------------------
  # ○ 敵キャラのＭＰ増減
  #--------------------------------------------------------------------------
  def convert_enemy_mp(args)
    enemy   = args["enemy"].to_i
    value   = args["value"]
    type    = value.gsub!(/(var\.)/) { "" } ? 1 : 0	#0:数値 1:変数
    operate = value.gsub!(/(^-)/)   { "" } ? 1 : 0	#0:加算 1:減算
    return RPG::EventCommand.new(332, @indent,
                                          [enemy, operate, type, value.to_i])
  end
  #--------------------------------------------------------------------------
  # ○ 敵キャラのステート変更
  #--------------------------------------------------------------------------
  def convert_enemy_state(args)
    enemy   = args["enemy"].to_i
    value   = args["value"]
    operate = value.gsub!(/(^-)/)   { "" } ? 1 : 0	#0:加算 1:減算
    return RPG::EventCommand.new(333, @indent, [enemy, operate, value.to_i])
  end
  #--------------------------------------------------------------------------
  # ○ 敵キャラの全回復
  #--------------------------------------------------------------------------
  def convert_enemy_all_recovery(args)
    enemy   = args["enemy"].to_i
    return RPG::EventCommand.new(334, @indent, [enemy])
  end
  #--------------------------------------------------------------------------
  # ○ 敵キャラの出現
  #--------------------------------------------------------------------------
  def convert_enemy_appear(args)
    enemy    = args["enemy"].to_i
    return RPG::EventCommand.new(335, @indent, [enemy])
  end
  #--------------------------------------------------------------------------
  # ○ 敵キャラの変身
  #--------------------------------------------------------------------------
  def convert_enemy_trans(args)
    enemy    = args["enemy"].to_i
    trans    = args["trans"].to_i
    return RPG::EventCommand.new(336, @indent, [enemy, trans])
  end
  #--------------------------------------------------------------------------
  # ○ 戦闘アニメーションの表示
  #--------------------------------------------------------------------------
  def convert_battle_anime(args)
    enemy    = args["enemy"].to_i
    anime    = args["anime"].to_i
    return RPG::EventCommand.new(337, @indent, [enemy, anime])
  end
  #--------------------------------------------------------------------------
  # ○ 戦闘行動の強制
  #--------------------------------------------------------------------------
  def convert_force(args)
    battler = args["battler"] == "enemy" ? 0 : 1
    id      = args["id"].to_i
    skill   = args["skill"].to_i
    target  = args["target"].to_i
    return RPG::EventCommand.new(339, @indent, [battler, id, skill, target])
  end
  #--------------------------------------------------------------------------
  # ○ バトルの中断
  #--------------------------------------------------------------------------
  def convert_battle_abort(args)
    return RPG::EventCommand.new(340, @indent, [])
  end
  
#****************************************************************************
# 上級系
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ スクリプト
  #--------------------------------------------------------------------------
  def convert_script(args)
    return RPG::EventCommand.new(355, @indent, [args["value"]])
  end
  #--------------------------------------------------------------------------
  # ○ スクリプト（２行目以降）
  #--------------------------------------------------------------------------
  def convert_script2(args)
    return RPG::EventCommand.new(655, @indent, [args["value"]])
  end
  
#****************************************************************************
# その他
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ イベントの終了位置
  #--------------------------------------------------------------------------
  def convert_end(args)
    @indent -= 1
    return RPG::EventCommand.new(0, @indent + 1, [])
  end
  
#****************************************************************************
# 後処理
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ 後処理
  #--------------------------------------------------------------------------
  alias tes_basic_set_post_processing post_processing
  def post_processing
    tes_basic_set_post_processing
    @route_h = 0
    @index   = 0
    while @data.size > @index
      post_processing_events
      @index += 1
    end
  end
  #--------------------------------------------------------------------------
  # ○ 後処理（各インデックスに対して）
  #--------------------------------------------------------------------------
  def post_processing_events
    # ルートタグのダミーをヘッダに収納
    if @data[@index].code == 205
      route_h = @index
      route = []
      while @data[@index + 1].code == 505
        @index += 1
        route << @data[@index].parameters[0]
      end
      route << RPG::MoveCommand.new
      @data[route_h].parameters[1].list = route
    end
    
    # ショップタグの先頭をヘッダコードに変換
    if @data[@index].code == 605
      @data[@index].code = 302
      while @data[@index + 1].code == 605
        @index += 1
      end
    end
  end

#****************************************************************************
# バリデータで出来ない値の確認
#****************************************************************************
  #--------------------------------------------------------------------------
  # ○ 数値確認
  #--------------------------------------------------------------------------
  def check_numeric(params, param_name, amin, amax)
    return unless params[param_name]
    unless params[param_name] =~ /^[-+0-9]\d*$/
      raise(TesConvertError,
      "[#{param_name}] : 数値以外が代入されました。")
    end
    
    # 最小値判定
    if min = amin
      min = params[min.id2name] if min.is_a?(Symbol)
      min = eval(min) if min.is_a?(String)
      min = min.to_i
      if params[param_name].to_i < min
        raise(TesConvertError,
        "[#{param_name}] : 最小値より小さい値が使われています。")
      end
    end
    
    # 最大値判定
    if max = amax
      max = params[max.id2name] if max.is_a?(Symbol)
      max = eval(max) if max.is_a?(String)
      max = max.to_i
      if params[param_name].to_i > max
        raise(TesConvertError,
        "[#{param_name}] : 最大値より大きい値が使われています。")
      end
    end
  end
  #--------------------------------------------------------------------------
  # ○ 必須要素
  #--------------------------------------------------------------------------
  def check_notEmpty(params, param_name)
    if !params[param_name] or params[param_name].empty?
      raise(TesConvertError,
      "[#{param_name}] : 必須引数が省略されています。")
    end
  end
end
end
