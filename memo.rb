require 'csv'

puts "メモアプリ - 1: 新規作成, 2: 編集"
user_choice = gets.chomp.to_i

if user_choice == 1
  puts "新しいメモを入力してください："
  new_memo = gets.chomp

  # 新規作成時
  puts "新しいファイル名を入力してください"
  file_name = gets.chomp

  # 新規ファイルを作成し、新しいメモを追加
  CSV.open('memos.csv', 'w') do |csv|
    csv << [new_memo]
  end

  puts "メモが保存されました。"
elsif user_choice == 2
  puts "編集するメモを選んでください："
  # 既存のファイルを読み込み、メモを表示
  CSV.foreach('memos.csv') do |row|
    puts row[0]
  end

  puts "編集したいメモの番号を入力してください："
  memo_number = gets.chomp.to_i

  puts "新しい内容を入力してください："
  new_content = gets.chomp

  # 編集時
  puts "編集するメモのファイル名を入力してください"
  file_name = gets.chomp

  # メモを編集してファイルに書き込み
  memos = CSV.read('memos.csv')
  memos[memo_number - 1] = [new_content]
  CSV.open('memos.csv', 'w') do |csv|
    memos.each do |memo|
      csv << memo
    end
  end

  puts "メモが編集されました。"
else
  puts "無効な選択です。"

# 新規作成時及び編集時の入力部分Ctrl+D検出
  puts "新しいメモを入力してください。Ctrl+Dで確定:"
  new_memo = ""
  while (line = $stdin.gets)
    new_memo += line  
end

  puts "新しい内容を入力してください。Ctrl+Dで確定:"
  new_content = ""
  while (line = $stdin.gets)
    new_content += line
end
end
