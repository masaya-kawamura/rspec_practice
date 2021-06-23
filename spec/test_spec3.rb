# letとlet!の違い
# 以下のコードでは、テストが失敗する
class Blog
  def initialize(title:, content:)
    @title = title
    @content = content
  end
end

describe Blog do
  let(:blog) { Blog.new(title: 'RSpec必勝法', content: 'あとで書く') }
  context 'ブログのテスト' do
    it 'ブログの取得ができること' do
      expect(Blog.first).to eq blog
    end
  end
end

# 上記のテストはletの遅延評価によってletで定義されたblogが呼び出されるのが一番最後になっている。
# このような場合は下記のように書くことでテストをパスすることができる

describe Blog do
  let(:blog) { Blog.create(title: 'RSpec必勝法', cotext: 'あとで書く') }
  before do
    blog #ここでデータベースのレコードを保存する
  end
  it 'ブログの取得ができること' do
    expect(Blog.first).to eq blog
  end
end
