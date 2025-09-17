BEGIN {
    RS = "\r\n\r\n(\r\n)+" # 줄바꿈 세 개 이상
    FS = "\r\n\r\n" # 줄바꿈 두 개
}
match($1, /^\[[0-9]+\]/) {
    # $1: 레시피 이름

    # RSTART: 매치된 문자열의 인덱스
    # RLENGTH: 매치된 문자열의 길이(문자 수)
    number = substr($1, RSTART+1, RLENGTH-2)

    split($1, name, /\r\n +/)
    name_en = name[1] # 영어 이름
    name_la = name[2] # 라틴어 이름
    
    gsub(/^\[[0-9]+\] /, "", name_en) # [n] 삭제
    gsub("_", "", name_la) # 밑줄 삭제

    # 번호만 있고 이름이 없는 경우
    if (name_en == "") {
        name_en = "UNNAMED"
        name_la = "INNOMINATUS"
    }

    filename = "data/apicius/recipes/" number " - " name_en " - " name_la ".txt"
    
    # $2: 레시피 본문
    body = $2
    gsub(/\r\n/, " ", body)

    print body > filename
    
}