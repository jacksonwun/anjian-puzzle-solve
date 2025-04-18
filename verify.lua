Dim pi
pi = 4 * Atn(1)  
dim defalut_delay_time = 500

Dim Success_time = 0
Dim Fail_time = 0
Dim Tried_time = 0

//xxx

move_puzzle()

Function xxx()
	While True
		If login(1) = 1 Then 
			login (0)
			Delay 5000
			move_puzzle 
			Delay 5000
			If login(1) = 1 Then 
				Success_time = Success_time + 1
				Tried_time = Tried_time + 1
				TracePrint "------------Success!!!", Success_time, "Tried: ", Tried_time
			Else 
				Fail_time = Fail_time + 1
				Tried_time = Tried_time + 1
				TracePrint "-------------Fail!!!!", Fail_time, "Tried:", Tried_time
				Delay 3000
				refresh(0)
				Delay 5000
			End If
		End If			
		If test_again(1) = 1 Then 
			test_again (0)
			Delay 5000
		End If
		If move_puzzle_button(1) = 1 Then 
			move_puzzle 
			Delay 5000
			If login(1) = 1 Then 
				Success_time = Success_time + 1
				Tried_time = Tried_time + 1
				TracePrint "------------Success!!!", Success_time, "Tried: ", Tried_time
			Else 
				Fail_time = Fail_time + 1
				Tried_time = Tried_time + 1
				TracePrint "-------------Fail!!!!", Fail_time, "Tried:", Tried_time
				Delay 3000
				refresh(0)
				Delay 5000
			End If
		End If
	Wend	
End Function

Function move_puzzle()
	Dim start_timestamp = Time()
	Dim start_time = Now()
	
	Dim right_top_x = determine_pic_vertx("right-top", "x")	
	Dim right_top_y = determine_pic_vertx("right-top", "y")
	Dim right_bottom_x = determine_pic_vertx("right-bottom", "x")	
	Dim right_bottom_y = determine_pic_vertx("right-bottom", "y")

	Dim left_top_x = determine_pic_vertx("left-top", "x")	
	Dim left_top_y = determine_pic_vertx("left-top", "y")
	Dim left_bottom_x = determine_pic_vertx("left-bottom", "x")	
	Dim left_bottom_y = determine_pic_vertx("left-bottom", "y")

	Dim area_length = right_bottom_y - right_top_y
	Dim area_height = right_top_x - left_top_x

	Dim can_find_move_puzzle_button

	TracePrint " . . . . .Settings . . . . ."
	TracePrint "Start Time: ", start_time
	Traceprint "Right Top: ", right_top_x, right_top_y	
	Traceprint "Right Bottom: ", right_bottom_x, right_bottom_y

	Traceprint "Left Top: ", left_top_x, left_top_y
	Traceprint "Left Bottom: ", left_bottom_x, left_bottom_y
	
	TracePrint "Area Length: ", area_length
	TracePrint "Area Height: ", area_height

	Dim estimated_pic_height = fix(area_length * 0.65)
	TracePrint "Estimated Pic Height: ", estimated_pic_height
	
	Dim GetColor_xx = GetPixelColor(269, 112)
	
	Dim DETECT_SENSITIVITY
	Dim CHECKER_CONSTANT
	If GetColor_xx = "97C7DD" or GetColor_xx = "97C6DF" or GetColor_xx = "A79C91" Then 
		DETECT_SENSITIVITY = 170
		CHECKER_CONSTANT = 80
	Else
		DETECT_SENSITIVITY = 170
		CHECKER_CONSTANT = 30		
	End If
	
	Dim STOP_WATCH_TIME = 90

	TracePrint "Detect Sensitivity: " , DETECT_SENSITIVITY
	TracePrint "Checker Constant: " , CHECKER_CONSTANT
	
	Dim check_point_color = GetPixelColor(right_top_x + area_length / 2, right_top_y - 30)

	Dim button_X, button_Y
	FindPic 0, 0, 0, 0, "Attachment:move_puzzle_button.png", "000000", 2, 0.9, button_X, button_Y
	If button_X > -1 And button_Y > -1 Then 
		can_find_move_puzzle_button = 1
	Else 
		FindPic 0, 0, 0, 0, "Attachment:move_puzzle_button_2.png", "000000", 2, 0.9, button_X, button_Y
		If button_X > -1 And button_Y > -1 Then 
			can_find_move_puzzle_button = 1
		End If
	End If	

	Dim yellow_puzzle_left_1_x = 0 
	Dim yellow_puzzle_left_1_y = 0
	Dim yellow_puzzle_left_2_x = 0
	Dim yellow_puzzle_left_2_y = 0

	//part_1
	ShowMessage "淏婓煦昴...1"
	Dim part_1_length = fix(area_length * 0.30)
	Dim check_x, check_y
	
	TracePrint "Part 1 Length: ", part_1_length

	check_x = left_top_x
	check_y = left_top_y + 20

	//check_y = left_top_x
	//check_x = left_top_y + 10
	
	TracePrint ""
	TracePrint " . . . . .Starting Part 1 . . . . ."
	Do
		Do
			ShowMessage "淏婓煦昴...1"
			Dim check_color = check_color_real_diff(check_x , check_y, check_x + 1, check_y)

			If check_color < - DETECT_SENSITIVITY Then 
				//TracePrint check_x , check_y
				//Traceprint check_color		
				
				Dim double_check_y = check_y
				Dim double_check_time_reverse = 0
				Dim count_double_check_time = 0

				Do
					Dim double_check_color = check_color_real_diff(check_x , double_check_y, check_x + 1, double_check_y)	
					//TracePrint check_x, double_check_y
					If double_check_color < - DETECT_SENSITIVITY Then 
						//TracePrint double_check_x , check_y
						//TracePrint double_check_color
						
						If count_double_check_time > 5 Then 
							//TracePrint check_x , double_check_y
							//TracePrint double_check_color
							
							If yellow_puzzle_left_1_x = 0 Then 
								yellow_puzzle_left_1_x = check_x
								yellow_puzzle_left_1_y = double_check_y
							End If
							yellow_puzzle_left_2_x = check_x
							yellow_puzzle_left_2_y = double_check_y							
							
						End If
						
						double_check_time_reverse = double_check_time_reverse - 1
						count_double_check_time = count_double_check_time + 1
						
						If stop_function(start_timestamp, STOP_WATCH_TIME) = 1 Then 
							exit do
						End If
					End If

					double_check_time_reverse = double_check_time_reverse + 1
					double_check_y = double_check_y + 1
					
					If stop_function(start_timestamp, STOP_WATCH_TIME) = 1 Then 
						exit do
					End If
				Loop Until check_y - double_check_y > 60 or double_check_time_reverse > 15

				If yellow_puzzle_left_1_x <> 0 and yellow_puzzle_left_1_x <> yellow_puzzle_left_2_x Then 
					Goto part_1_end
				End If
			End If

			check_x = check_x + 1
		Loop Until check_x > left_top_x + part_1_length / 4  //quicker
		check_y = check_y + 10
		check_x = left_top_x
	Loop Until check_y < right_top_y - estimated_pic_height or yellow_puzzle_left_1_x <> 0
	
	Rem part_1_end
	
	TracePrint "Yellow Puzzle Left 1 x", yellow_puzzle_left_1_x
	TracePrint "Yellow Puzzle Left 1 y", yellow_puzzle_left_1_y
	TracePrint "Yellow Puzzle Left 2 x", yellow_puzzle_left_2_x
	TracePrint "Yellow Puzzle Left 2 y", yellow_puzzle_left_2_y	
	
	ShowMessage yellow_puzzle_left_1_x, yellow_puzzle_left_1_y
	
	//Part 2 start
	TracePrint ""
	TracePrint " . . . . .Starting Part 2 . . . . ."
	ShowMessage "淏婓煦昴...2" 
	Dim yellow_puzzle_right_1_x = 0 
	Dim yellow_puzzle_right_1_y = 0
	Dim yellow_puzzle_right_2_x = 0
	Dim yellow_puzzle_right_2_y = 0
	
	check_x = yellow_puzzle_left_1_x + Round(part_1_length / 4)
	check_y = yellow_puzzle_left_1_y - 10
	
	If yellow_puzzle_left_1_x = 26 and yellow_puzzle_left_2_x = 26 Then 
		//yellow_puzzle_right_1_x = 68
		//yellow_puzzle_right_1_y = yellow_puzzle_left_1_y
		//yellow_puzzle_right_2_x = 68
		//yellow_puzzle_right_2_y = yellow_puzzle_left_2_y
		//Goto part_2_end
		check_x = 68
	ElseIf yellow_puzzle_left_1_x = 30 and yellow_puzzle_left_2_x = 30 Then
		//yellow_puzzle_right_1_x = 72
		//yellow_puzzle_right_1_y = yellow_puzzle_left_1_y
		//yellow_puzzle_right_2_x = 72
		//yellow_puzzle_right_2_y = yellow_puzzle_left_2_y
		//Goto part_2_end
		check_x = 72
	ElseIf yellow_puzzle_left_1_x = 33 and yellow_puzzle_left_2_x = 33 Then
		//yellow_puzzle_right_1_x = 74
		//yellow_puzzle_right_1_y = yellow_puzzle_left_1_y
		//yellow_puzzle_right_2_x = 74
		//yellow_puzzle_right_2_y = yellow_puzzle_left_2_y
		//Goto part_2_end
		check_x = 74
	End If
	
	Dim start_x = check_x - 2
	
	If check_point_color = GetPixelColor(right_top_x + area_length / 2, right_top_y - 30) and yellow_puzzle_left_1_x <> 0 Then 
		Do
			Do
				ShowMessage "淏婓煦昴...2" 
				check_color = check_color_real_diff(check_x, check_y, check_x + 1, check_y)
				//TracePrint check_x, check_y				
				
				If check_color > DETECT_SENSITIVITY * 1.3 Then 
					yellow_puzzle_right_1_x = 0
					//TracePrint "checked", check_x, check_y
					//TracePrint check_color
					
					double_check_y = check_y - 20 //check from higher point
					count_double_check_time = 0
					
					Do
						check_color = check_color_real_diff(check_x, double_check_y, check_x + 1, double_check_y)
						//TracePrint "checked", check_x, double_check_y

						If check_color > DETECT_SENSITIVITY Then 
							count_double_check_time = count_double_check_time + 1
							//TracePrint check_x, double_check_y
							//TracePrint check_color
						End If
	
						If count_double_check_time > 2 Then 
							If yellow_puzzle_right_1_x = 0 Then 
								yellow_puzzle_right_1_x = check_x
								yellow_puzzle_right_1_y = double_check_y								
							End If
	
							yellow_puzzle_right_2_x = check_x
							yellow_puzzle_right_2_y = double_check_y	
						End If	
	
						double_check_y = double_check_y + 1

						If stop_function(start_timestamp, STOP_WATCH_TIME) = 1 Then 
							exit do
						End If

					Loop Until double_check_y > yellow_puzzle_left_2_y
					
					Dim vertical_checker = move_puzzle_checker(yellow_puzzle_right_1_x, yellow_puzzle_right_1_y, yellow_puzzle_right_2_x, yellow_puzzle_right_2_y, "yellow", CHECKER_CONSTANT)
					//TracePrint "vertical_checker: " , vertical_checker
					
					If count_double_check_time > 5 and vertical_checker = 1 Then 
						Goto part_2_end
					Else 
						//TracePrint "Status 2 Vertical checker: " , vertical_checker
					End If
					
				End If
				
				check_x = check_x + 1
			Loop Until check_x > left_top_x + part_1_length * 0.8
			
			check_x = start_x
			check_y = check_y + 1
		Loop Until check_y > yellow_puzzle_left_2_y
	End If
	
	Rem part_2_end
	
	If yellow_puzzle_right_1_x > right_top_x * 0.95 Then 
		TracePrint "Error! x is too high"
		yellow_puzzle_right_1_x = 0
		yellow_puzzle_right_1_y = 0
		yellow_puzzle_right_2_x = 0
		yellow_puzzle_right_2_y = 0
	End If
	
	TracePrint "Yellow Puzzle Right 1 x", yellow_puzzle_right_1_x
	TracePrint "Yellow Puzzle Right 1 y", yellow_puzzle_right_1_y
	TracePrint "Yellow Puzzle Right 2 x", yellow_puzzle_right_2_x
	TracePrint "Yellow Puzzle Right 2 y", yellow_puzzle_right_2_y	

	//part3 start
	TracePrint ""
	TracePrint " . . . . .Starting Part 3 . . . . ."
	ShowMessage "淏婓煦昴...3"
	Dim black_puzzle_right_1_x = 0
	Dim black_puzzle_right_1_y = 0
	Dim black_puzzle_right_2_x = 0
	Dim black_puzzle_right_2_y = 0
	
	check_x = yellow_puzzle_right_1_x + Round(part_1_length / 10)
	
	If check_point_color = GetPixelColor(right_top_x + area_length / 2, right_top_y - 30) and yellow_puzzle_right_1_x <> 0 Then 
		Do
			ShowMessage "淏婓煦昴...3" 
			check_y = yellow_puzzle_right_1_y
			check_color = check_color_real_diff(check_x, check_y, check_x + 1, check_y)
			count_double_check_time = 0
			black_puzzle_right_1_x = 0
			black_puzzle_right_1_y = 0

			If check_color < -DETECT_SENSITIVITY Then 
				Do

					check_color = check_color_real_diff(check_x, check_y + 1, check_x + 1, check_y + 1)
					If check_color < - DETECT_SENSITIVITY Then 
						count_double_check_time = count_double_check_time + 1
						//TracePrint check_x, check_y
						//TracePrint check_color
						//TracePrint count_double_check_time
					End If
					
					//If count_double_check_time > 1 Then 
					//TracePrint check_x
					If black_puzzle_right_1_x = 0 Then 
						black_puzzle_right_1_x = check_x
						black_puzzle_right_1_y = check_y
							
						//TracePrint "black_puzzle_right_1_x", black_puzzle_right_1_x
						//TracePrint "black_puzzle_right_1_y", black_puzzle_right_1_y
					End If
	
					black_puzzle_right_2_x = check_x
					black_puzzle_right_2_y = check_y
						
						//TracePrint "black_puzzle_right_2_x", black_puzzle_right_2_x
						//TracePrint "black_puzzle_right_2_y", black_puzzle_right_2_y
					//End If
					
					check_y = check_y + 1
					If stop_function(start_timestamp, STOP_WATCH_TIME) = 1 Then 
						exit do
					End If
				Loop Until check_y > yellow_puzzle_right_2_y

				vertical_checker = move_puzzle_checker(black_puzzle_right_1_x, black_puzzle_right_1_y, black_puzzle_right_2_x, black_puzzle_right_2_y, "dark", CHECKER_CONSTANT )

				If count_double_check_time > 5 and vertical_checker = 1 Then 
					If black_puzzle_right_1_x - yellow_puzzle_right_1_x > yellow_puzzle_left_1_x Then // 窪衵衵 > 酘 
						If black_puzzle_right_1_x <> 0 and black_puzzle_right_1_y <> 0 Then //窪衵奻x硉祥脹黺0
							//TracePrint "Part 3 Done"
							Goto part_3_end	
						End If
					End If
				Else 
					//TracePrint "vertical_checker", vertical_checker
				End If

			End If
			check_x = check_x + 1
		Loop Until check_x > right_top_x
	End If

	Rem part_3_end
	
	TracePrint "Black Puzzle Right 1 x", black_puzzle_right_1_x
	TracePrint "Black Puzzle Right 1 y", black_puzzle_right_1_y
	TracePrint "Black Puzzle Right 2 x", black_puzzle_right_2_x
	TracePrint "Black Puzzle Right 2 y", black_puzzle_right_2_y

	TracePrint ""
	TracePrint " . . . . .Starting Part 4 . . . . ."
	ShowMessage black_puzzle_right_1_x, black_puzzle_right_1_y

	If black_puzzle_right_1_x <> 0 Then 
		Dim target_x = black_puzzle_right_1_x - yellow_puzzle_right_1_x //+ button_X
		
		TracePrint "Move button to right (Location) ", target_x + button_X
		
		Dim track_list = mouse_track(button_X, target_x)
		Dim max_i = UBound(track_list)	
		Dim i = 0
		
		TouchDown button_X, button_Y + 5, 1
		
		Do
			If i > 6 Then   ///Y have to change
				button_Y = button_Y + 1
			End If
			TouchMove track_list(i) , button_Y, 1
			i = i + 1
			//TracePrint "here"
			
			If stop_function(start_timestamp, STOP_WATCH_TIME) = 1 Then 
				exit do
			End If
			
		Loop Until i > max_i
		
		Delay random_number(20, 50)
		TouchUp 1
	End If
	
	//Rem fail_to_solve_puzzle
	If black_puzzle_right_1_x = 0 Then 
		TracePrint "Solve Puzzle Fail"
	End If
	
End Function

Function mouse_track(button_X, target_x)
	Dim x = 0
	Dim i = 0
	Dim equation_checker = 0
	Dim equation_output
	Dim track_list = Array()
	Do
		equation_output = ease_in_out_expo2(x)
		track_list(i) = Fix(button_X + equation_output * target_x)
		
		If x > 0.2 and x < 0.8 Then 
			x = x + 0.13 + 0.01 * random_number(0, 100) / 100
		ElseIf equation_output < 0.2 and x < 1 Then
			x = x + 0.03 + 0.01 * random_number(0, 100) / 100
		ElseIf equation_output > 0.8 and x < 1 Then
			x = x + 0.02 + 0.01 * random_number(0, 100) / 100	
		ElseIf x > 1.01 Then
			x = x - 0.01 - 0.01 * random_number(0, 100) / 100
		Else  
			x = x + 0.01 + 0.01 * random_number(0, 100) / 100
		End If
		
		//TracePrint x, equation_output, track_list(i)
		
		i = i + 1
	Loop Until equation_output > 0.985 and equation_output < 1.015
	mouse_track() = track_list
End Function

Function mouse_track_time(button_X, target_x, SLIDE_TIME)
	Dim x = 0
	Dim i = 0
	Dim equation_checker = 0
	Dim equation_output
	Dim track_list = Array()
	Dim x_list = Array()
	Dim slide_time_list = Array()
	Dim Return = Array()
	
	Do
		//TracePrint x_list(i - 1), equation_output, track_list(i - 1), slide_time_list(i - 1) //The previous x
		equation_output = ease_in_out_expo2(x)
		track_list(i) = Fix(button_X + equation_output * target_x)
		If i = 0 Then 
			x_list(i) = x
			slide_time_list(i) = 0
		Else 
			x_list(i) = x
			slide_time_list(i) = (x_list(i) - x_list(i - 1)) * SLIDE_TIME
			
		End If
		
		If equation_output < 0.2 Then 
			x = x + 0.06 + 0.01 * random_number(0, 100) / 100
		ElseIf equation_output < 0.8 Then
			x = x + 0.30 + 0.1 * random_number(0, 100) / 100
		Else 
			x = x + 0.06 + 0.01 * random_number(0, 100) / 100
		End If
		
		i = i + 1
	Loop Until equation_output > 0.97 and equation_output < 1.03
	
	Return(0) = track_list
	Return(1) = slide_time_list
	mouse_track_time() = Return
End Function

Function move_puzzle_checker(black_puzzle_right_1_x, black_puzzle_right_1_y, black_puzzle_right_2_x, black_puzzle_right_2_y, yellow, CHECKER_CONSTANT)
	//TracePrint "Black puzzle right 1: ", black_puzzle_right_1_x, black_puzzle_right_1_y, "Black puzzle right 2: ", black_puzzle_right_2_x, black_puzzle_right_2_y
	
	Dim black_puzzle_right_x = round((black_puzzle_right_1_x + black_puzzle_right_2_x) / 2)
	Dim black_puzzle_right_y = round((black_puzzle_right_1_y + black_puzzle_right_2_y) / 2)
	
	Dim black_puzzle_right_y_start = black_puzzle_right_y - 30
	Dim black_puzzle_right_y_end = black_puzzle_right_y + 30
	
	Dim checker_y = black_puzzle_right_y_start
	Dim checker_x = black_puzzle_right_x - 1
	
	//TracePrint "Start y: ", black_puzzle_right_y_start, "End y: ", black_puzzle_right_y_end
	
	Dim checker_up = 0
	Dim checker_down = 0
	Dim checker_up_y = 0
	Dim checker_down_y = 0
	
	If yellow = "yellow" Then 
		Do
			Dim checker_color = check_color_real_diff(checker_x, checker_y, checker_x, checker_y + 1)
			If checker_color < - CHECKER_CONSTANT and check_color_real_diff(checker_x - 1, checker_y, checker_x - 1, checker_y + 1) < - CHECKER_CONSTANT and checker_up = 0 Then 
				checker_up_y = checker_y
				//TracePrint "checker_x", checker_x
				//TracePrint "checker_y( < -100) :", checker_y
				//TracePrint "checker_color( < -100): ", checker_color
				checker_up = 1
			End If
			If checker_color > CHECKER_CONSTANT and check_color_real_diff(checker_x - 1, checker_y, checker_x - 1, checker_y + 1) > CHECKER_CONSTANT  Then 
				checker_down_y = checker_y
				//TracePrint "checker_y( > 100) :", checker_y
				//TracePrint "checker_color( > 100): " , checker_color
				checker_down = 1
			End If
			checker_y = checker_y + 1
		Loop Until checker_y = black_puzzle_right_y_end
	Else
		Do
			//TracePrint checker_y
			//TracePrint checker_color
			checker_color = check_color_real_diff(checker_x, checker_y, checker_x, checker_y + 1)
			If checker_color > CHECKER_CONSTANT and check_color_real_diff(checker_x - 1, checker_y, checker_x - 1, checker_y + 1) > CHECKER_CONSTANT and checker_up = 0 Then 
				checker_up_y = checker_y
				//TracePrint checker_y
				//TracePrint checker_color
				checker_up = 1
			End If
			If checker_color < -CHECKER_CONSTANT and check_color_real_diff(checker_x - 1, checker_y, checker_x - 1, checker_y + 1) < -CHECKER_CONSTANT  Then 
				checker_down_y = checker_y
				//TracePrint checker_y
				//TracePrint checker_color
				checker_down = 1
			End If
			checker_y = checker_y + 1
		Loop Until checker_y = black_puzzle_right_y_end	
	End If		
	
	If checker_up = 1 and checker_down = 1 and Abs(checker_down_y - checker_up_y) > 20 Then //the puzzle height
		move_puzzle_checker() = 1
	Else 
		move_puzzle_checker() = 0
	End If
	
End Function

Function ease_out_expo(x)
	If x = 1 Then 
		ease_out_expo() = 1
	Else 
		ease_out_expo() = 1 - 2 ^ (-10 * (x + 0.01 * 1 * random_number(0,5)) )
	End If
End Function

Function ease_in_out_expo3(x)
	If x = 1 Then 
		ease_in_out_expo3() = 1
	ElseIf x < 0.3 Then
		ease_in_out_expo3() = 1 - Cos(0.5 * 3.14 * x) + (0.05 * random_number(0, 100) / 100)
	ElseIf x < 0.75 Then
		ease_in_out_expo3() = 1 - Cos(0.5 * 3.14 * x * 1.5) * 0.69 - 0.35 + (0.05 * random_number(0, 100) / 100)
	Else 
		ease_in_out_expo3() = 1 - Cos(0.5 * 3.14 * x) * 0.2 + 0.08 + (0.05 * random_number(0, 100) / 100)
	End If
End Function

Function ease_in_out_expo2(x) //success
	If x = 1 Then 
		ease_in_out_expo2() = 1
	ElseIf x < 0.3 Then
		ease_in_out_expo2() = 1 - Cos(0.5 * pi * x * 1.05) //+ 0.01 * random_number(-5, 5)
	ElseIf x < 0.55 Then
		Dim xx = (1 - Cos(0.5 * pi * x * 2.3)) / 1.3 
		Dim xx_2 = (Sin(0.5 * pi * x * 2.3)) / 1.3 
		
		//TracePrint("x", x)
		//TracePrint(xx)
		//TracePrint(xx_2)
		ease_in_out_expo2() = xx + xx_2 - 0.958 + 0.01 * random_number(0, 100) / 100
	Else 
		ease_in_out_expo2() = Sin(0.5 * pi * x * 1.2) * 1.6 - 0.55 + 0.01 * random_number(0, 100) / 100
	End If
End Function

Function ease_in_out_expo(x)
	If x = 1 Then 
		ease_in_out_expo() = 1
	ElseIf x < 0.3 Then
		ease_in_out_expo() = 1 - Cos(0.5 * 3.14 * x) + 0.02 * random_number(0, 100) / 100
	Else 
		ease_in_out_expo() = 1 - Cos(0.5 * 3.14 * x * 2.5) * 0.69 - 0.62 + 0.02 * random_number(0, 100) / 100
	End If
End Function

Function ease_out_bounce(x)
	Dim n1 = 7.5625
	Dim d1 = 2.75
	If x < 1 / d1 Then 
		ease_out_bounce() = n1 * x * x + 0.01
	ElseIf x < 2 / d1 Then
		x = x - 1.5 / d1
		ease_out_bounce() = n1 * x * x + 0.75
	ElseIf x < 2.5 / d1 Then
		x = x - 2.25 / d1
		ease_out_bounce() = n1 * x * x + 0.9375
	Else 
		x = x - 2.625 / d1
		ease_out_bounce() = n1 * x * x + 0.984375
	End If
End Function

//define formula or logical

Function castle_wall_y(x, res)
	castle_wall_y() = fix(1.2 * x - res)
End Function

Function delay_time(x)
	Delay defalut_delay_time * x
End Function

Function random_number(min_x, max_x)
	Dim x
	Do
		x = Int(((max_x - min_x + 1) * Rnd()) + min_x)   
	Loop Until min_x - 1 < x < max_x +1
	random_number() = x
End Function

//verify related

Function check_color_real_diff(x_1, y_1, x_2, y_2)
	Dim color_1 = GetPixelColor(x_1, y_1)
	Dim color_2 = GetPixelColor(x_2, y_2)
	Dim r_1,g_1,b_1
	Dim r_2,g_2,b_2	
	
	ColorToRGB color_1, r_1,g_1,b_1
	ColorToRGB color_2, r_2,g_2,b_2	
	
	check_color_real_diff() = r_1 + g_1 + b_1 - (r_2 + g_2 + b_2)
End Function

Function Getcolor(color_x, color_move)
	Getcolor() = GetPixelColor(color_x, color_move,0)
End Function

Function Getcolor_diff(GetColor_A, color_x, color_move)
	Getcolor_diff() = ColorDiff(GetColor_A, Getcolor(color_x, color_move))
End Function

Function std(arr)
	Dim i, sum=0
	For Each i in arr
		i = (i - average(arr)) ^ 2
		sum = sum + i
	Next
	std() = Sqr(sum / (UBOUND(arr) + 1))
End Function

Function average(arr)
    Dim sum
    For Each str In arr
        sum = sum + str
    Next
	average() = sum / (UBound(arr) + 1)
End Function

Function click(min_y, max_y)
	Dim intX, intY
	FindPic 0, 0, 0, 0, "Attachment:move_puzzle_button.png", "000000", 0, 0.9, intX, intY
	If intX > -1 And intY > -1 Then 
		TouchDown intX, intY, 1
	End If	
	//Touch 210, 400, 5000
	Delay 500
	//Swipe 210, 400, 210, (final_location_y + 10 + color_move)
	TouchMove 210, (min_y + max_y) / 2 - 10, 1
	Delay 500
	TouchMove 210, (min_y + max_y) / 2 - 5, 1
	Delay 500
	TouchMove 210, (min_y + max_y) / 2, 1
	Delay 500
	//Tap 210, (final_location_y + 10  + color_move) / 2
	Delay 500
	TouchUp 1
End Function

Function button()
	Dim intX,intY
	FindMultiColor 0,0,0,0,"FAFAFA","-11|27|F9F9F8,-14|4|F8F8F8,-5|23|F9F9F9,-18|26|F8F8F8,-19|49|00D266,-9|43|F9F9F9,2|48|00D266,-1|49|00D266,1|47|00D266",4,0.8,intX,intY
	If intX > -1 And intY > -1 Then
		button() = 1
	End If
End Function

Function determine_pic_vertx(dimension, x_y)
	Dim int_length, int_height
	Dim estimated_left_top_x = 0
	Dim estimated_left_top_y = 80
	Dim estimated_right_bottom_x = 300
	Dim estimated_right_bottom_y = 400


	Dim intX_2,intY_2
	FindMultiColor estimated_left_top_x,estimated_left_top_y,estimated_right_bottom_x,estimated_right_bottom_y,"FFFFFF","3|15|FFFFFF,-5|2|FFFFFF,0|9|FFFFFF",0,0.9,intX_2,intY_2  
	If intX_2 > -1 And intY_2 > -1 Then
		//TracePrint intX_2,intY_2     //left-top
	End If
	
	Dim intX_3,intY_3
	FindMultiColor estimated_left_top_x,estimated_left_top_y,estimated_right_bottom_x,estimated_right_bottom_y,"FFFFFF","3|15|FFFFFF,-5|2|FFFFFF,0|9|FFFFFF",4,0.9,intX_3,intY_3   
	If intX_3 > -1 And intY_3 > -1 Then
		//TracePrint intX_3,intY_3      //right-top
	End If
	
	Dim intX_4,intY_4	
	FindMultiColor estimated_left_top_x,estimated_left_top_y,estimated_right_bottom_x,estimated_right_bottom_y,"FFFFFF","3|15|FFFFFF,-5|2|FFFFFF,0|9|FFFFFF",3,0.9,intX_4,intY_4  
	If intX_4 > -1 And intY_4 > -1 Then
		//TracePrint intX_4,intY_4    //left-bottom
	End If
	
	Dim intX_1,intY_1
	FindMultiColor estimated_left_top_x,estimated_left_top_y,estimated_right_bottom_x,estimated_right_bottom_y,"FFFFFF","3|15|FFFFFF,-5|2|FFFFFF,0|9|FFFFFF",2,0.9,intX_1,intY_1
	If intX_1 > -1 And intY_1 > -1 Then
		//TracePrint intX_1,intY_1    //right-bottom
	End If	
	
	If dimension = "right-bottom" Then 
		If x_y = "x" Then 
			determine_pic_vertx() = intX_1
		ElseIf x_y = "y" Then 
			determine_pic_vertx() = intY_1	
		End If
	ElseIf dimension = "left-top" Then 
		If x_y = "x" Then 
			determine_pic_vertx() = intX_2
		ElseIf x_y = "y" Then 
			determine_pic_vertx() = intY_2	
		End If
	ElseIf dimension = "right-top" Then 
		If x_y = "x" Then 
			determine_pic_vertx() = intX_3
		ElseIf x_y = "y" Then 
			determine_pic_vertx() = intY_3
		End If
	ElseIf dimension = "left-bottom" Then 
		If x_y = "x" Then 
			determine_pic_vertx() = intX_4
		ElseIf x_y = "y" Then 
			determine_pic_vertx() = intY_4
		End If
	End If
	
	//int_length = intX_1 - intX_2
	//int_height = intY_1 - intY_2
	//If dimension = "length" Then 
	//	determine_pic_size() = int_length
	//ElseIf dimension = "height" Then 
	//	determine_pic_size() = int_height
	//End If
End Function

Function stop_function(start_timestamp, stopwatch_time)
	Dim now_time = Time()
	If now_time - start_timestamp > stopwatch_time Then 
		stop_function() = 1
	End If
End Function

//Pic related

Function login(genre)
	Dim intX,intY
	FindPic 0,0,0,0,"Attachment:login.png","000000",0,0.9,intX,intY
	If intX > -1 And intY > -1 Then
		If genre = 0 Then 
			Tap intX, intY
		ElseIf genre = 1 Then
			login() = 1
		End If
	End If
End Function

Function test_again(genre)
	Dim intX,intY
	FindPic 0,0,0,0,"Attachment:test_again.png","000000",0,0.9,intX,intY
	If intX > -1 And intY > -1 Then
		If genre = 0 Then 
			Tap intX, intY
		ElseIf genre = 1 Then
			test_again() = 1
		End If
	End If
End Function

Function move_puzzle_button(genre)
	Dim intX,intY
	FindPic 0, 0, 0, 0, "Attachment:move_puzzle_button.png", "000000", 0, 0.8, intX, intY
	If intX > -1 And intY > -1 Then 
		If genre = 0 Then 
			Tap intX, intY
		ElseIf genre = 1 Then
			move_puzzle_button() = 1
		End If
	End If
End Function

Function refresh(genre)
	Dim intX,intY
	FindPic 0, 0, 0, 0, "Attachment:refresh.png", "000000", 3, 0.8, intX, intY
	If intX > -1 And intY > -1 Then 
		If genre = 0 Then 
			Tap 60, 360
		ElseIf genre = 1 Then
			refresh() = 1
		End If
	End If
End Function