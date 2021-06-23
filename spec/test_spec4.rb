# どうしても動かないコードに:pendingをつける

describe '繊細なクラス' do
  it '繊細なテスト' do
    expect(1 + 2).to eq 3

    pending 'この先はなぜかテストが失敗するのであとで直す'
    #パスしないエクスペクテーションを(実行される)
    expect(foo).to eq bar
  end
end

# 問答無用でテストの実行を止める：skip

describe '何らかの理由で実行したくないクラス' do
  it '実行したくないテスト' do
    expect(1 + 2).to eq 3

    skip 'とりあえずここで実行を保留'
    #ここから先は実行されない
    expect(foo).to eq bar
  end
end

# 手っ取り早くexample全体をskipさせる: xit

describe '何らかの理由で実行したくないクラス' do
  xit '実行したくないテスト' do
    expect(1 + 2).to eq 3

    expect(foo).to eq bar
  end
end

# グループ全体をスキップさせる：:xdescribe / xcontaxt

xdescribe '四則演算' do
  it '1 + 1 は 2 になること' do
    expect(1 + 1).to eq 2
  end
  it '10 - 1 は 9 になること' do
    expect(10 - 1).to eq 9
  end
end

# テストは後で書く：中身の無いit
# itのdoとendを省略するとpendingのテストとしてマークされる。

class User
  def initialize(name:, age:)
    @name = name
    @age = age
  end

  def greet
    if age <= 12
      "ぼくは#{name}です"
    else
      "僕は#{name}です。"
    end
  end
end

describe User do
  describe '#good_bye' do
    context '12歳以下のの場合' do
      it 'ひらがなでさようならをすること'
    end
    context '13歳以上の場合' do
      it '漢字でさようならすること'
    end
  end
end
