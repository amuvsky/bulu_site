require "fileutils"

page_lists = ["about.html", "news.html", "scene.html", "sketch.html", "story.html", "video.html", "index.html"]
char_page_lists = ["bulu.html", "baba.html", "shop_keeper.html"]

def build_layout(layout, page)
  layout_buffer = []
  page_buffer = []

  layout_file = File.open(layout, "r")
  page_file = File.open(page, "r")

  new_page = File.open("#{page}.new", "w")
  match_comment = 0

  layout_file.each_line do |line|
    match_comment = match_comment + 1 if line.match("<!-------------------------------------------------------------------->")

    if match_comment == 1 and ! line.match("<!-------------------------------------------------------------------->")
      next
    elsif match_comment == 1 and line.match("<!-------------------------------------------------------------------->")
      page_match_comment = 0
      page_file.each_line do |page_line|
        page_match_comment = page_match_comment + 1 if page_line.match("<!-------------------------------------------------------------------->")
        new_page.puts page_line if page_match_comment == 1
      end
    else
      new_page.puts line
    end
  end
  layout_file.close
  page_file.close
  new_page.close

  FileUtils.mv("#{page}.new", "#{page}")
end

page_lists.each do |page|
  build_layout("index.lay", page)
end

char_page_lists.each do |page|
  build_layout("char.lay", page)
end
