BEGIN {
    RS = "\r\n\r\n(\r\n)+" # 줄바꿈 세 개 이상
    FS = "\r\n\r\n" # 줄바꿈 두 개
    ORS = "\n***\n"
}
match($1, /^\[[0-9]+\]/) {
    print $1 # 요리 이름 출력
}