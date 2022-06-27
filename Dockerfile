# 2020/10/14最新versionを取得
FROM golang:1.15.2-alpine
#FROM golang:1.13.12
# アップデートとgitのインストール
RUN apk update && apk add git
# appディレクトリの作成
RUN mkdir /go/src/app
# ワーキングディレクトリの設定
WORKDIR /go/src/app
# ホストのファイルをコンテナの作業ディレクトリに移行
ADD . /go/src/app
# RUN GO111MODULE=off go get github.com/oxequa/realize
    # sqlを使うためのモジュール
RUN go get -u github.com/go-sql-driver/mysql
# CMD ["realize", "start"]
RUN go build -o go-app app/main.go && \
    chmod 770 go-app && \
    mv go-app /
ENTRYPOINT ["/go-app"]