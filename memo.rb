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


  CSV.open(new_csv_filename, 'w') do |csv|
    csv << [file_name, new_memo]
  end
  puts "メモが保存されました。"
end

# 編集時
def edit_existing_memo
  puts "編集するメモのファイル名を入力してください："
  file_name = gets.chomp
  target_file = "#{file_name}.csv"

  if File.exist?(target_file)
    puts "現在の内容は以下の通りです："
    current_content = CSV.read(target_file)[0][1]
    puts current_content

    puts "新しい内容を入力してください。Ctrl+Dで確定:"
    new_content = ""
    while (line = $stdin.gets)
      break if line.chomp == "\x04"  # Ctrl+Dを検出してループを抜ける
      new_content += line
    end

    # ファイルの内容を更新
    CSV.open(target_file, 'w') do |csv|
      csv << [file_name, new_content]
    end
    puts "メモが編集されました。"
  else
    puts "指定したファイルが見つかりません。"
  end
end

# ユーザーとのやり取り
puts "メモアプリ - 1: 新規作成, 2: 編集"
user_choice = gets.chomp.to_i

if user_choice == 1
  create_new_memo
elsif user_choice == 2
  edit_existing_memo
else
  puts "無効な選択です。"
end
