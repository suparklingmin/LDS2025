# Linguistics and Data Science
# [HW02] AWK
# Author: Sumin Park
# Date: 2025-09-15

BEGIN {
    RS="\r\n\r\n(\r\n)+" # CRLF
    FS="\r\n\r\n"
    ORS=""
}
# 대괄호로 둘러싸인 레시피 번호가 매치되는 경우
match($1, /^\[[0-9]+\]/) {

    # 매치된 레시피 번호를 추출한다 (대괄호 제외)
    number = substr($1, RSTART+1, RLENGTH-2)

    # 1번 필드를 영어 이름과 라틴어 이름으로 분리한다
    split($1, name, "\r\n  +")
    name_en = name[1]
    name_la = name[2]
    
    gsub(/^\[[0-9]+\] ?/, "", name_en) # 영어 이름에서 행번호 제거
    gsub(/_/, "", name_la) # 라틴어 이름에서 밑줄 제거

    # 요리 이름이 없는 경우 채워 준다
    if (name_en == "") {
        name_en = "UNNANMED"
        name_la = "INNOMINATUS"
    }

    filename = "data/apicius/recipes/" number " - " name_en " - " name_la ".txt"

    # 레시피 본문에서 줄바꿈을 제거한다
    body = $2
    gsub(/\r\n/, " ", body)

    # 모든 각주에서 줄바꿈과 들여쓰기를 제거한다
    notes = ""
    for (i=3; i<=NF; i++) {
        gsub(/(    +|\t)/, "", $i) # 들여쓰기 제거
        gsub(/\r\n/, " ", $i) # 줄바꿈 제거
        notes = notes $i "\n"
    }

    # 본문과 각주 사이에 -----를 추가하여 출력한다
    print body "\n-----\n" notes > filename
}
