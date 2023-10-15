require 'csv'

# 新規
def create_new_memo
  puts "新しいメモを入力してください. Ctrl+Dで確定:"
  new_memo = ""
  while (line = $stdin.gets)
    break if line.chomp == "\x04"  # Ctrl+Dを検出してループを抜ける
    new_memo += line
  end

  puts "新しいファイル名を入力してください："
  file_name = gets.chomp
  new_csv_filename = "#{file_name}.csv"  # ファイル名に .csv 拡張子を追加

  # memos.csv ファイルが存在しない場合は新規に作成
  unless File.exist?('memos.csv')
    CSV.open('memos.csv', 'w') do |csv|
      csv << ["Title", "Content"]
    end
  end

  CSV.open(new_csv_filename, 'w') do |csv|
    csv << [file_name, new_memo]
  end
  puts "メモが保存されました。"
end

# 編集時
def edit_existing_memo
  puts "編集するメモを選んでください："
  # 既存のファイルを読み込み、メモを表示
  memos = []
  CSV.foreach('memos.csv') do |row|
    memos << row
  end

  memos.each_with_index do |memo, index|
    puts "#{index + 1}: #{memo[0]}"
  end

  puts "編集したいメモの番号を入力してください："
  memo_number = gets.chomp.to_i

  if memo_number <= 0 || memo_number > memos.length
    puts "無効な番号です。"
    return
  end

  puts "新しい内容を入力してください。Ctrl+Dで確定:"
  new_content = ""
  while (line = $stdin.gets)
    break if line.chomp == "\x04"  # Ctrl+Dを検出してループを抜ける
    new_content += line
  end

  memo = memos[memo_number - 1]
  memo[1] = new_content

  CSV.open('memos.csv', 'w') do |csv|
    memos.each do |m|
      csv << m
    end
  end

  puts "メモが編集されました。"
end

puts "メモアプリ - 1: 新規作成, 2: 編集"
user_choice = gets.chomp.to_i

if user_choice == 1
  create_new_memo
elsif user_choice == 2
  edit_existing_memo
else
  puts "無効な選択です。"
end
