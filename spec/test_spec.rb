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


describe '四則演算' do
  it '1 + 1 は 2 になること' do
    expect(1 + 1).to eq 2
    expect(10 - 1).to eq 9
    expect(4 * 8).to eq 32
    expect(40 / 5).to eq 8
  end
  it '10 - 1 は 9 になること' do
    expect(10 - 1).to eq 9
  end
end

describe '#greet' do
  it '12歳以下の場合、ひらがなで答えること' do
    user = User.new(name: 'たろう', age: 12)
    expect(user.greet).to eq 'ぼくはたろうだよ。'
  end
  it '13歳以上の場合は、感じで答えること' do
    user = User.new(name: 'たろう', age: 13)
    expect(user.greet).to eq '僕はたろうです。'
  end
end

describe User do
  describe "#greet" do
    context '#12歳以下の場合' do
      it 'ひらがなで答えること' do
        user = User.new(name: 'たろう', age: 12)
        expect(user.greet).to eq 'ぼくはたろうだよ。'
      end
    end
    context '13歳以上の場合' do
      it '漢字で答えること' do
        user = User.new(name: 'たろう', age: 13)
        expect(user.greet).to eq '僕はたろうです。'
      end
    end
  end
end

# beforeはexampleの実行前に毎回呼ばれる。

describe User do
  describe "#greet" do
    before do
      @params = { name: 'たろう'}
    end
    context '12際以下の場合' do
      it 'ひらがなで答えること' do
        user = User.new(@params.merge(age: 12))
        expect(user.greet).to eq 'ぼくはたろうだよ。'
      end
    end
    context '13歳以上の場合' do
      it '感じで答えること' do
        user = User.new(@params.merge(age: 13))
        expect(user.greet).to eq '僕はたろうです。'
      end
    end
  end
end

# ネストしたdescribeやcontextの中でbeforeを使う
# describeやcontextがネストしている場合には親子関係に応じてbeforeが順番に呼ばれる

describe User do
  describe '#greet' do
    before do
      @params = { name: 'たろう' }
    end
    context '12歳以下の場合' do
      before do
        @params.merge!(age: 12)
      end
      it 'ひらがなで答えること' do
        user = User.new(@params)
        expect(user.greet).to eq 'ぼくはたろうだよ。'
      end
    end
    context '13歳以上の場合' do
      before do
        @params.merge!(age: 13)
      end
      it '漢字で答えること' do
        user = User.new(@params)
        expect(user.greet).to eq '僕はたろうです。'
      end
    end
  end
end

# インスタンス変数のかわりにletを使う

describe User do
  describe '#greet' do
    let(:params) { { name: 'たろう' } }
    context '12際以下の場合' do
      before do
        params.merge!(age: 12)
      end
      it 'ひらがなで答えること' do
        user = User.new(params)
        expect(user.greet).to eq 'ぼくはたろうだよ。'
      end
    end
    context '13歳以上の場合' do
      before do
        params.merge!(age: 13)
      end
      it '感じで答えること' do
        user = User.new(params)
        expect(user.greet).to eq '僕はたろうです。'
      end
    end
  end
end

# let(:params) { { name } }の意味とは

# let(:params) do
#   hash = {}
#   hash[:name] = "たろう"
#   hash
# end

