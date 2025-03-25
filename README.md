# 読み旅

## サイト概要
### サイトテーマ
本と、本に登場する舞台を紹介し、交流するSNS
​
### テーマを選んだ理由
本と旅をつなげるサイトを作成したくて、このテーマを選びました。
文字だけの想像の世界から、実際の場所を訪れることは、想像が現実に重なる貴重な体験です。この体験をいろんな人に感じてほしいと思っています。
ドラマやアニメの舞台を紹介するサイトはありますが、本にスポットを当てたサイトが調べた範囲では見当たらなかったため、今回ポートフォリオとして作成しようとテーマに選びました。
​
### ターゲットユーザ
 - 読書が好きな人
 - 旅が好きな人
 - テーマを持った旅をしてみたい人

### 主な利用シーン
旅行の計画を立てるときに、ガイドブックのように使ってほしいです。
自分が訪れようとしている場所が作品の舞台になっていると、楽しみ方が変わるのではなでしょうか。舞台となっている場所を訪れる前に本を読み、本も舞台も両方楽しんでほしいと思います。
​
## 設計書
### 非会員ができること
- 書籍詳細情報の表示
- スポット詳細情報の表示
- 全書籍・スポット一覧の表示
- ジャンル別一覧の表示
- スポット地域別一覧の表示

### 会員ができること
#### マイページの表示
 - プロフィールの表示・編集
 - 各投稿の一覧表示
#### 他の会員のページの表示
 - プロフィールの表示
 - 各投稿の一覧表示
#### 書籍の新規投稿・編集機能
 - 検索から新規投稿
 - 手動で新規投稿
 - 関連スポットの登録
 - 自分で投稿した内容の編集
 - マイページから投稿済みの書籍一覧を確認
#### スポットの新規登録・編集機能
 - 手動で新規投稿
 - 関連書籍の登録
 - 自分で投稿した内容の編集
 - マイページから投稿済みのスポット一覧を確認
#### ブックマーク機能
 - 気になる本をブックマーク
 - マイページからブックマーク済みの一覧を確認
#### 行きたい！機能
 - 行ってみたいスポットを登録
 - マイページから行きたい！済みの一覧を確認
#### 行ったよ！機能
 - 実際に行ったスポットを登録
 - マイページから行ったよ！済みの一覧を確認
#### 感想投稿機能
 - 登録済みの書籍の感想を投稿
 - マイページから投稿済みの感想一覧を確認
#### コメント投稿機能
 - 登録済みのスポットに関するコメント投稿
 - マイページから投稿済みのコメント一覧を確認
#### フォロー機能
 - 他の会員をフォロー
 - マイページからフォロー済みの会員一覧を確認
#### 検索機能
 - 書籍の検索
 - スポットの検索
 - 会員の検索
​
### 管理者ができること
- 書籍情報の編集・削除
- スポット情報の編集・削除
- 会員情報の編集・削除
- 感想の削除
- コメントの削除
- ジャンルの新規登録
- スポット地域の登録・編集・削除

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
- API：楽天ブックス書籍検索API

## 使用素材
### アイコンとして以下を使用
#### FontAwesome
 - ブックマークアイコン
https://fontawesome.com/icons/bookmark
 - 本アイコン
https://fontawesome.com/icons/book?f=classic&s=solid
 - スポットアイコン
https://fontawesome.com/icons/location-pin?f=classic&s=solid
 - 行きたい！アイコン
https://fontawesome.com/icons/face-grin-hearts?f=classic&s=solid
 - 行ったよ！アイオン
https://fontawesome.com/icons/thumbs-up?f=classic&s=solid
 - フォロー・フォロワーアイコン
https://fontawesome.com/icons/people-arrows?f=classic&s=solid
 - マイページアイコン
https://fontawesome.com/icons/user?f=classic&s=solid
 - ログインアイコン
https://fontawesome.com/icons/arrow-right-to-bracket?f=classic&s=solid
 - 編集アイコン
https://fontawesome.com/icons/gears?f=classic&s=solid
 - ログアウトアイコン
https://fontawesome.com/icons/arrow-right-from-bracket?f=classic&s=solid
 - 新規登録アイコン
https://fontawesome.com/icons/user-plus?f=classic&s=solid
 - aboutページアイコン
https://fontawesome.com/icons/circle-question?f=classic&s=solid