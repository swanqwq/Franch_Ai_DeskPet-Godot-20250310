extends Control
@onready var chat_text: ChatText = $ChatText



#func _ready() -> void:
	#line_edit.text_submitted.connect(on_submitted)
	#line_edit.text_changed.connect(on_submitted)
	#line_edit.text_submitted.connect(on_submitted)
	#line_edit.request_finished.connect(on_request_finished)

	#把大模型文件内的request_finished信号传入on_request_finished方法
	#line_edit.text_submitted.connect(on_input_submitted)  # 连接回车信号
	#get_tree().root.set_transparent_background(true)
	#get_viewport().transparent_bg = true#透明屏幕
	#sentences = [
		#"Je suis perdu… dans ton cœur.",
		#"​Psst… Tu sais que je t’aime ?",#嘘…你知道我爱你吗？
		#"Les étoiles sont dans le ciel, mais toi… tu es dans mon café.",#星星在天上，而你…在我的咖啡里。
		#"​Chaque jour avec toi est magique ✨",#和你在一起的每一天都像魔法！
		##"Hop! Je saute dans ton cœur !",#嘿咻！我要跳进你心里啦
		#"​Ne t’inquiète pas, je suis là !",
		#"Mon petit chou",
		#"​Bisou",
		#"​Coucou",
		#"​Câlin",
		#"Mon trésor",
		#"Salut",
		#"Ça va?"]#别担心，我陪着你呢！

#func on_submitted(new_text:String):
		##if new_text.begins_with("#"):
			##var command_array = new_text.split(" ")
				##if         command_dict.has(command_array[1]):
							##check_command(command_array[1])
		##else:
			#chat_text.ask(new_text)
			##show_text("让我想想",0.5)
#

		

#func _on_charactor_chat() -> void:
#	var answer_from_chatText = chat_text.answer  # 直接访问成员变量
	#chat_text.text = answer_from_chatText
	#chat_text.text = sentences.pick_random()#随机选择句子
	#chat_text.play_chat()
	##当接受到chat信号时：播放函数plat_chat()-即文字动画
	
#接受输入的文字new_text，处理，调用输出文字的函数 call_aliyun
