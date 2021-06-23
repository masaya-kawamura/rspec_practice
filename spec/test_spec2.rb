class User

  def initialize(name:, age:)
    @name = name
    @age = age
  end

  def greet
    if @age <= 12
      "ぼくは#{@name}だよ。"
    else
      "僕は#{@name}です。"
    end
  end
end

#userをletにする

describe User do
  describe '#greet' do
    let(:user) { User.new(params) }
    let(:params) { { name: 'たろう' } }
    context '12歳以下の場合' do
      before do
        params.merge!(age: 12)
      end
      it 'ひらがなで答えること' do
        expect(user.greet).to eq 'ぼくはたろうだよ。'
      end
    end
    context '13歳以下の場合' do
      before do
        params.merge!(age: 13)
      end
      it '漢字でこたえること' do
        expect(user.greet).to eq '僕はたろうです。'
      end
    end
  end
end

# 上記のコードはlet!を使って置き換えることができる
# let!を使うことによって事前評価をし、blogを呼び出す前に呼び出す処理を行うことができる。
describe Blog do
  let!(:blog) {Blog.create(title: 'RSpec必勝法', content: 'あとで書く') }
  it 'ブログを取得できること' do
    expect(Blog.first).to eq blog
  end
end

# letを使うことで、itの中でわざわざuser =
# User.newを定義しなくても参照できるようになった
# letはそれ自体が変数でグローバル変数のような動作をする?
# letの中にはインスタンス変数も格納することができて、
# この場合のletはUserのインスタンスに置き換えられていることになる。
# なのでケーキ屋さんでcustomerのインスタンスをletに格納するには以下のようになる。

# let(:customer) { Costomer.new(params) }
# let(:params) { { last_name: '山田',
#                 first_name: '太郎',
#                 last_name_kana: 'やまだ',
#                 first_name_kana: 'たろう'} }
# みたいになって...
# この情報を使うためには、customer.インスタンスメソッドのように使うことができる。


# let(:params) { { name } }の意味とは
# let(:params) do
#   hash = {}
#   hash[:name] = "たろう"
#   hash
# end

# letのメリット活かしてageもletで置き換える

describe User do
  describe '#greet' do
    let(:user) { User.new(params) }
    let(:params) { { name: 'たろう', age: age } }
    context '12歳以下のの場合' do
      let(:age) { 12 }
      it 'ひらがなで答えること' do
        expect(user.greet).to eq 'ぼくはたろうだよ。'
      end
    end
    context '13歳以上の場合' do
      let(:age) { 13 }
      it '漢字でこたえること' do
        expect(user.greet).to eq '僕はたろうです。'
      end
    end
  end
end

# subjectを使って手スロ対象のオブジェクトを1箇所にまとめる
# 今までexpect(user.greet)と書いていた部分をis_expectedに置き換えることができる

describe User do
  describe '#greet' do
    let(:user) { User.new(params) }
    let(:params) { { name: 'たろう', age: age } }
    subject { user.greet }
    context '12歳以下の場合' do
      let(:age) { 12 }
      it 'ひらがなで答えること' do
        is_expected.to eq 'ぼくはたろうだよ。'
      end
    end
    context '13歳以上の場合' do
      let(:age) { 13 }
      it '漢字で答えること' do
        is_expected.to eq '僕はたろうです。'
      end
    end
  end
end

