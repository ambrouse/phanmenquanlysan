<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="/style/snowflake-14-xxl.png">
    <link rel="stylesheet" href="./style/reset.css">
    <link rel="stylesheet" href="./style/style.css">
</head>
<body>
   <div class="main">
    <div class="main__infomation">
        <div class="main__infomation--item">
            <div class="item__logo">
                <img src="./style/snowflake-14-xxl.png" alt="">
            </div>
        </div>
        <div class="main__infomation--item">
            <div class="item__contact">
                <div class="item__contact--title">
                    <p>Liên lạc</p>  
                    <span></span>        
                </div>
                <div class="item__contact--main">
                    <div class="main__phone">
                        <p>Điện thoại: 03260....</p>
                    </div>
                    <div class="main__email">
                        <p>Gmail: thich....@gmail.com</p>
                    </div>
                    <div class="main__address">
                        <p>Địa Chỉ: ....</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="main__infomation--item">
            <div class="item__skill">
                <div class="item__skill--title">
                    <p>Kĩ năng</p>
                    <span></span>
                </div>
                <div class="item__skill--main">
                    <div class="main__web">
                        <div class="main__web--title">
                            <p>Web và App :</p>
                        </div>
                        <div class="main__web--main">
                            <p>-Reactjs, Flutter</p>
                            <p>-Asp.net, Spring boot, Flast</p>
                        </div>
                    </div>
                    <div class="main__ai">
                        <div class="main__ai--title">
                            <p>Học Máy và Học Sâu :</p>
                        </div>
                        <div class="main__ai--main">
                            <p>-Tensorflow, Numpy, Pandas</p>
                            <p>-LNP(LSTM, RNN, Tranfomer)</p>
                            <p>-Machine Leaning(DeCision tree, Association rule, KNN, Kmean)</p>
                        </div>
                    </div>
                    <div class="main__game">
                        <div class="main__game--title">
                            <p>Game :</p>
                        </div>
                        <div class="main__game--main">
                            <p>-Unity</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="main__infomation--item">
            <div class="item__langguage">
                <div class="item__langguage--title">
                    <p>Các ngôn ngữ lập trình thông thạo</p>
                    <span></span>
                </div>
                <div class="item__langguage--main">
                    <p>Java script</p>
                    <p>Java</p>
                    <p>C#</p>
                    <p>Python</p>
                    <p>Dart</p>
                </div>
            </div>
        </div>
    </div>
    <div class="main__deriptions">
        <div class="main__deriptions--title">
            <p>Đơn Xin Việc</p>
        </div>
        <div class="main__deriptions--desription">
            <p>Giới thiệu</p>
            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Impedit neque inventore esse laudantium temporibus. Iusto, vitae maxime harum eos libero voluptatibus voluptate quibusdam laboriosam rem deserunt. Similique saepe necessitatibus dolor.</p>
        </div>
        <div class="main__deriptions--exp">
            <div class="exp__title">
                <p>Các dự án đã làm</p>
            </div>
            <div class="exp__main">
                <div class="exp__main--item">
                    <div class="item__title">
                        <p>Web and App</p>
                    </div>
                    <div class="item__main">
                        <div class="item__main--item">
                            <div class="item__name">
                                <span>- Tên dự án : </span>
                                <span>Website thương mại điện tử bán xe</span>
                            </div>
                            <div class="item__deription">
                                <span>Mô tả :</span>
                                <span>Một website được xây dựng bằng framework asp.net với chủ đề chính lad phục vụ cho một cửa hàng bán xe.</span>
                            </div>
                            <div class="item__link">
                                <p  onclick=openPodup(5)>Chi tiết: !!</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="main__deriptions--location">
            <div class="location__title">
                <p>Vi Tri Cong Viec Ung Tuyen</p>
            </div>
            <div class="location__item">
                <p>Web Dev Fullstask.</p>
            </div>
        </div>
        <div class="main__podup">
            <div class="main__podup--item">
                <div class="item__title">
                    <p>Chi tiết</p>
                </div>
                <div class="item__deription">
                    <div class="item__deription--title">
                        <p>Chi tiết về dự án</p>
                    </div>
                    <div class="item__deription--main">
                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Cumque in maxime necessitatibus autem, quod eum non aspernatur, iste fugiat, corporis vero cupiditate aliquid error omnis eos! Autem cumque amet culpa.</p>
                    </div>
                </div>
                <div class="item__deription">
                    <div class="item__deription--title">
                        <p>ý tưởng của dự án</p>
                    </div>
                    <div class="item__deription--main">
                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Cumque in maxime necessitatibus autem, quod eum non aspernatur, iste fugiat, corporis vero cupiditate aliquid error omnis eos! Autem cumque amet culpa.</p>
                    </div>
                </div>
                <div class="item__deription">
                    <div class="item__deription--title">
                        <p>Mô hình, các framework của dự án</p>
                    </div>
                    <div class="item__deription--main">
                        <p>Mô hình MVC và không dùng api, code trên một framework duy nhất là asp.net</p>
                    </div>
                </div>
                <div class="item__deription">
                    <div class="item__deription--title">
                        <p>Các thành viên của dự án</p>
                    </div>
                    <div class="item__deription--main">
                        <p>Duy, Bảo(bản thân)</p>
                    </div>
                </div>
                <div class="item__deription">
                    <div class="item__deription--title">
                        <p>Vị trí trong nhóm</p>
                    </div>
                    <div class="item__deription--main">
                        <p>leader, Dev Fullstask, BA, Tester</p>
                    </div>
                </div>
                
                <div class="main__podup--btn" onclick=closePodup(5)>
                    <span></span>
                    <span></span>
                </div>
            </div>
        </div>
    </div>
   </div>
</body>
</html>
