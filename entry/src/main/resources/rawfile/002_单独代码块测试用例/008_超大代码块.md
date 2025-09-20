```css
第1页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>天空颜色的奥秘：瑞利散射的作用</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
    <style>
        @font-face {
            font-family: 'Source Han Sans CN';
            src: local('Source Han Sans CN'), local('思源黑体');
            font-weight: normal;
        }
        
        body, html {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "Source Han Sans CN", sans-serif;
        }
        
        .slide-container {
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #1A7BB7 0%, #0D4D73 100%);
            color: #F9FBFC;
            position: relative;
            overflow: hidden;
        }
        
        .medical-bg-elements {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0.1;
            pointer-events: none;
        }
        
        .heartbeat-line {
            position: absolute;
            bottom: 15%;
            left: 0;
            width: 100%;
            height: 80px;
            stroke: #F9FBFC;
            stroke-width: 2;
            fill: none;
        }
        
        .dna-helix {
            position: absolute;
            top: 10%;
            right: 10%;
            width: 200px;
            height: 400px;
            opacity: 0.2;
        }
        
        .medical-cross {
            position: absolute;
            bottom: 10%;
            right: 10%;
            font-size: 120px;
            opacity: 0.15;
            color: #F9FBFC;
        }
        
        .circle-element {
            position: absolute;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(76, 175, 120, 0.2) 0%, rgba(26, 123, 183, 0.1) 70%);
        }
        
        .circle-1 {
            width: 300px;
            height: 300px;
            top: -100px;
            left: -100px;
        }
        
        .circle-2 {
            width: 500px;
            height: 500px;
            bottom: -200px;
            right: -200px;
        }
        
        .content {
            position: relative;
            z-index: 10;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 0 10%;
        }
        
        .title {
            font-size: 48pt; /* 增大字体 */
            font-weight: bold;
            margin-bottom: 20px;
            line-height: 1.2;
        }
        
        .subtitle {
            font-size: 30pt; /* 增大字体 */
            margin-bottom: 48px;
            opacity: 0.9;
        }
        
        .presenter-info {
            position: absolute;
            right: 10%;
            bottom: 120px; /* 调整位置到右下方 */
            display: flex;
            align-items: center;
        }
        
        .presenter-avatar {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background-color: #F9FBFC;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 16px;
        }
        
        .presenter-avatar i {
            font-size: 35px;
            color: #1A7BB7;
        }
        
        .presenter-details {
            font-size: 18pt;
        }
        
        .presenter-name {
            font-weight: bold;
            font-size: 22pt;
        }
        
        .presenter-title {
            opacity: 0.8;
            font-size: 16pt;
        }
        
        .footer {
            position: absolute;
            bottom: 32px;
            left: 0;
            width: 100%;
            display: flex;
            justify-content: space-between;
            padding: 0 10%;
            box-sizing: border-box;
        }
        
        .date {
            font-size: 16pt;
            opacity: 0.8;
        }
        
        .logo {
            font-size: 28pt;
            font-weight: bold;
            color: #F9FBFC;
        }
        
        .accent-bar {
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 8px;
            height: 120px;
            background-color: #4CAF78;
            border-radius: 0 4px 4px 0;
        }
        
        .grid-lines {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0.05;
            pointer-events: none;
        }
        
        .grid-line {
            position: absolute;
            background-color: #F9FBFC;
        }
        
        .horizontal-line {
            width: 100%;
            height: 1px;
        }
        
        .vertical-line {
            width: 1px;
            height: 100%;
        }
    </style>
</head>
<body class="bg-gray-100">
    <div class="slide-container">
        <!-- 背景装饰元素 -->
        <div class="medical-bg-elements">
            <!-- 心电图线 -->
            <svg class="heartbeat-line" viewBox="0 0 1200 100">
                <path d="M0,50 Q50,50 100,50 T200,50 T300,50 T400,50 L450,50 L475,20 L500,80 L525,20 L550,50 L600,50 Q650,50 700,50 T800,50 T900,50 T1000,50 T1100,50 T1200,50" />
            </svg>
            
            <!-- DNA双螺旋 -->
            <div class="dna-helix">
                <svg viewBox="0 0 100 400">
                    <path d="M30,0 Q70,50 30,100 Q70,150 30,200 Q70,250 30,300 Q70,350 30,400" stroke="#F9FBFC" stroke-width="2" fill="none" />
                    <path d="M70,0 Q30,50 70,100 Q30,150 70,200 Q30,250 70,300 Q30,350 70,400" stroke="#F9FBFC" stroke-width="2" fill="none" />
                    
                    <!-- 连接线 -->
                    <line x1="30" y1="50" x2="70" y2="50" stroke="#F9FBFC" stroke-width="1.5" />
                    <line x1="30" y1="150" x2="70" y2="150" stroke="#F9FBFC" stroke-width="1.5" />
                    <line x1="30" y1="250" x2="70" y2="250" stroke="#F9FBFC" stroke-width="1.5" />
                    <line x1="30" y1="350" x2="70" y2="350" stroke="#F9FBFC" stroke-width="1.5" />
                </svg>
            </div>
            
            <!-- 医学十字 -->
            <div class="medical-cross">
                <i class="fas fa-plus"></i>
            </div>
        </div>
        
        <!-- 圆形元素 -->
        <div class="circle-element circle-1"></div>
        <div class="circle-element circle-2"></div>
        
        <!-- 网格线 -->
        <div class="grid-lines">
            <div class="grid-line horizontal-line" style="top: 25%"></div>
            <div class="grid-line horizontal-line" style="top: 50%"></div>
            <div class="grid-line horizontal-line" style="top: 75%"></div>
            <div class="grid-line vertical-line" style="left: 25%"></div>
            <div class="grid-line vertical-line" style="left: 50%"></div>
            <div class="grid-line vertical-line" style="left: 75%"></div>
        </div>
        
        <!-- 强调条 -->
        <div class="accent-bar"></div>
        
        <!-- 内容区域 -->
        <div class="content">
            <div class="title-container">
                <div class="title">天空颜色的奥秘：瑞利散射的作用</div>
                <div class="subtitle">探索大气光学现象的科学原理</div>
            </div>
        </div>
        
        <!-- 汇报人信息移至右下侧 -->
        <div class="presenter-info">
            <div class="presenter-avatar">
                <i class="fas fa-user-graduate"></i>
            </div>
            <div class="presenter-details">
                <div class="presenter-name">李教授</div>
                <div class="presenter-title">大气物理研究所 首席研究员</div>
            </div>
        </div>
        
        <!-- 页脚 -->
        <div class="footer">
            <div class="date">2023年10月15日</div>
            <div class="logo">大气物理研究所</div>
        </div>
    </div>
</body>
</html>

第2页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>瑞利散射现象解析</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
    <style>
        @font-face {
            font-family: 'Source Han Sans CN';
            src: local('Source Han Sans CN'), local('思源黑体');
            font-weight: normal;
        }
        
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "Source Han Sans CN", sans-serif;
        }
        
        .slide-container {
            width: 100%;
            height: 100vh;
            display: flex;
            background-color: #F9FBFC;
            position: relative;
        }
        
        .left-sidebar {
            width: 12%;
            height: 100%;
            background-color: #1A7BB7;
            position: relative;
            overflow: hidden;
        }
        
        .left-sidebar::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(76, 175, 120, 0.2) 0%, rgba(26, 123, 183, 0) 70%);
        }
        
        .content-area {
            width: 88%;
            height: 100%;
            padding: 2% 3%;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
        }
        
        .header {
            margin-bottom: 1.5rem;
        }
        
        .title {
            font-size: 46px;
            font-weight: bold;
            color: #1A7BB7;
            margin-bottom: 0.5rem;
        }
        
        .subtitle {
            font-size: 30px;
            color: #607D8B;
        }
        
        .toc-container {
            display: flex;
            flex-grow: 1;
            margin-top: 1rem;
        }
        
        .toc-column {
            flex: 1;
            padding-right: 1.5rem;
        }
        
        .toc-item {
            display: flex;
            align-items: center;
            margin-bottom: 1.8rem;
            padding: 1rem;
            border-radius: 10px;
            transition: all 0.3s ease;
            cursor: pointer;
            background-color: rgba(26, 123, 183, 0.05);
        }
        
        .toc-item:hover {
            background-color: rgba(26, 123, 183, 0.15);
            transform: translateX(5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        .toc-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background-color: #1A7BB7;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1.5rem;
            flex-shrink: 0;
            font-size: 24px;
        }
        
        .toc-text {
            flex-grow: 1;
        }
        
        .toc-title {
            font-size: 26px;
            font-weight: bold;
            color: #1A7BB7;
            margin-bottom: 0.5rem;
        }
        
        .toc-description {
            font-size: 20px;
            color: #607D8B;
        }
        
        .toc-page {
            font-size: 24px;
            color: #4CAF78;
            font-weight: bold;
            margin-left: 1rem;
        }
        
        .decoration {
            position: absolute;
            opacity: 0.1;
        }
        
        .dna {
            bottom: 5%;
            right: 5%;
            width: 250px;
            height: 250px;
        }
        
        .heartbeat {
            top: 10%;
            right: 15%;
            width: 200px;
            height: 70px;
        }
        
        .footer {
            display: flex;
            justify-content: space-between;
            padding-top: 1rem;
            border-top: 1px solid rgba(96, 125, 139, 0.2);
            color: #607D8B;
            font-size: 18px;
            margin-top: 1rem;
        }
    </style>
</head>
<body class="bg-gray-100">
    <div class="slide-container">
        <!-- 左侧装饰条 -->
        <div class="left-sidebar"></div>
        
        <!-- 内容区域 -->
        <div class="content-area">
            <!-- 标题区域 -->
            <div class="header">
                <h1 class="title">瑞利散射现象解析</h1>
                <p class="subtitle">天空颜色的科学解释</p>
            </div>
            
            <!-- 目录内容 -->
            <div class="toc-container">
                <!-- 左侧目录列 -->
                <div class="toc-column">
                    <div class="toc-item">
                        <div class="toc-icon">
                            <i class="fas fa-atom"></i>
                        </div>
                        <div class="toc-text">
                            <div class="toc-title">瑞利散射的基本原理</div>
                            <div class="toc-description">光与大气分子的相互作用</div>
                        </div>
                        <div class="toc-page">01</div>
                    </div>
                    
                    <div class="toc-item">
                        <div class="toc-icon">
                            <i class="fas fa-question-circle"></i>
                        </div>
                        <div class="toc-text">
                            <div class="toc-title">为何是蓝色而非紫色</div>
                            <div class="toc-description">人眼感知与太阳光谱</div>
                        </div>
                        <div class="toc-page">02</div>
                    </div>
                    
                    <div class="toc-item">
                        <div class="toc-icon">
                            <i class="fas fa-sun"></i>
                        </div>
                        <div class="toc-text">
                            <div class="toc-title">日出日落时的红色天空</div>
                            <div class="toc-description">光程增加与散射变化</div>
                        </div>
                        <div class="toc-page">03</div>
                    </div>
                </div>
                
                <!-- 右侧目录列 -->
                <div class="toc-column">
                    <div class="toc-item">
                        <div class="toc-icon">
                            <i class="fas fa-wind"></i>
                        </div>
                        <div class="toc-text">
                            <div class="toc-title">其他影响因素</div>
                            <div class="toc-description">气溶胶、湿度与污染</div>
                        </div>
                        <div class="toc-page">04</div>
                    </div>
                    
                    <div class="toc-item">
                        <div class="toc-icon">
                            <i class="fas fa-clipboard-check"></i>
                        </div>
                        <div class="toc-text">
                            <div class="toc-title">总结</div>
                            <div class="toc-description">瑞利散射的综合解释</div>
                        </div>
                        <div class="toc-page">05</div>
                    </div>
                </div>
            </div>
            
            <!-- 页脚 -->
            <div class="footer">
                <div>大气光学现象解析 v1.0</div>
                <div>© 2023 科学教育中心</div>
            </div>
        </div>
        
        <!-- 装饰元素 -->
        <svg class="decoration dna" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
            <path d="M30,20 Q50,50 30,80 M70,20 Q50,50 70,80" stroke="#1A7BB7" stroke-width="2" fill="none"/>
            <path d="M30,30 L70,30 M30,40 L70,40 M30,50 L70,50 M30,60 L70,60 M30,70 L70,70" stroke="#1A7BB7" stroke-width="1" fill="none"/>
        </svg>
        
        <svg class="decoration heartbeat" viewBox="0 0 100 20" xmlns="http://www.w3.org/2000/svg">
            <path d="M0,10 L10,10 L15,5 L20,15 L25,5 L30,15 L35,5 L40,10 L50,10 L55,5 L60,15 L65,5 L70,15 L75,5 L80,10 L100,10" stroke="#E57373" stroke-width="1" fill="none"/>
        </svg>
    </div>
</body>
</html>

第3页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>瑞利散射的基本原理</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "思源黑体", sans-serif;
        }
        
        .slide-container {
            width: 100%;
            height: 100vh;
            display: flex;
            background-color: #F9FBFC;
            position: relative;
        }
        
        .left-bar {
            width: 120px;
            height: 100%;
            background-color: #1A7BB7;
            position: relative;
            overflow: hidden;
        }
        
        .left-bar::before {
            content: "";
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background-color: rgba(76, 175, 120, 0.2);
            top: -100px;
            left: -150px;
        }
        
        .left-bar::after {
            content: "";
            position: absolute;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background-color: rgba(76, 175, 120, 0.15);
            bottom: -50px;
            left: -100px;
        }
        
        .content {
            flex: 1;
            padding: 60px 80px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .chapter-title {
            font-size: 48px;
            font-weight: bold;
            color: #1A7BB7;
            margin-bottom: 30px;
        }
        
        .chapter-description {
            font-size: 24px;
            color: #607D8B;
            max-width: 700px;
            line-height: 1.6;
        }
        
        .medical-icon {
            position: absolute;
            right: 60px;
            bottom: 60px;
            font-size: 150px;
            color: rgba(26, 123, 183, 0.1);
        }
        
        .dna-decoration {
            position: absolute;
            top: 40px;
            right: 40px;
            width: 220px;
            height: 100px;
        }
        
        .heartbeat-line {
            position: absolute;
            bottom: 30px;
            left: 150px;
            width: 350px;
            height: 50px;
            opacity: 0.2;
        }
    </style>
</head>
<body>
    <div class="slide-container">
        <div class="left-bar"></div>
        <div class="content">
            <h1 class="chapter-title">瑞利散射的基本原理</h1>
            <p class="chapter-description">
                瑞利散射是指当光线通过不均匀介质时，由于介质中微小颗粒的存在，
                光线向各个方向散射的现象。其散射强度与波长的四次方成反比，
                解释了为什么天空呈现蓝色而日落时呈现红色。
            </p>
        </div>
        
        <div class="medical-icon">
            <i class="fas fa-atom"></i>
        </div>
        
        <svg class="dna-decoration" viewBox="0 0 100 40" xmlns="http://www.w3.org/2000/svg">
            <path d="M10,20 Q25,5 40,20 T70,20 T100,20" stroke="#1A7BB7" stroke-width="1" fill="none" opacity="0.3"/>
            <path d="M10,20 Q25,35 40,20 T70,20 T100,20" stroke="#1A7BB7" stroke-width="1" fill="none" opacity="0.3"/>
            <circle cx="10" cy="20" r="2" fill="#4CAF78" opacity="0.5"/>
            <circle cx="40" cy="20" r="2" fill="#4CAF78" opacity="0.5"/>
            <circle cx="70" cy="20" r="2" fill="#4CAF78" opacity="0.5"/>
            <circle cx="100" cy="20" r="2" fill="#4CAF78" opacity="0.5"/>
            <circle cx="25" cy="12.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="25" cy="27.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="55" cy="12.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="55" cy="27.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="85" cy="12.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="85" cy="27.5" r="1.5" fill="#E57373" opacity="0.5"/>
        </svg>
        
        <svg class="heartbeat-line" viewBox="0 0 100 20" xmlns="http://www.w3.org/2000/svg">
            <path d="M0,10 L10,10 L15,3 L25,17 L35,3 L45,17 L50,10 L60,10 L65,5 L70,15 L75,5 L85,10 L100,10" 
                  stroke="#1A7BB7" 
                  stroke-width="1.5" 
                  fill="none"/>
        </svg>
    </div>
</body>
</html>

第4页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>光学现象PPT模板 - 瑞利散射原理</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body, html {
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "思源黑体", sans-serif;
            background-color: #F5F9FC;
        }
        
        .slide-container {
            width: 100%;
            height: 100%;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        
        .header {
            height: 60px;
            background: linear-gradient(90deg, #0A5D94 0%, #3A9C6C 100%);
            position: relative;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            z-index: 10;
        }
        
        .header::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><path d="M0,50 Q25,25 50,50 T100,50" fill="none" stroke="rgba(255,255,255,0.15)" stroke-width="2" /></svg>');
            background-size: 100px 100px;
            opacity: 0.5;
        }
        
        .header-content {
            padding: 0 40px;
            height: 100%;
            color: white;
            position: relative;
            z-index: 2;
            font-size: 18px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .header-icon {
            margin-right: 15px;
            font-size: 22px;
            color: rgba(255,255,255,0.9);
        }
        
        .content {
            flex: 1;
            position: relative;
            background-color: #F5F9FC;
            display: flex;
            flex-direction: column;
            padding: 15px 30px 20px;
        }
        
        .title-section {
            margin-bottom: 15px;
            position: relative;
        }
        
        .title {
            font-size: 36px;
            font-weight: bold;
            color: #0A5D94;
            margin-bottom: 8px;
            position: relative;
            display: inline-block;
        }
        
        .title::after {
            content: "";
            position: absolute;
            bottom: -6px;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #0A5D94 0%, #3A9C6C 100%);
            border-radius: 2px;
        }
        
        .subtitle {
            font-size: 24px;
            color: #607D8B;
            font-weight: 500;
        }
        
        .content-wrapper {
            display: flex;
            justify-content: center; /* 水平居中 */
            align-items: center; /* 垂直居中 */
            gap: 20px;
            flex: 1;
        }
        
        .content-column {
            flex: 0 1 auto; /* 不强制拉伸，根据内容自适应宽度 */
            max-width: 45%; /* 限制最大宽度 */
            display: flex;
            flex-direction: column;
            justify-content: center; /* 垂直居中 */
        }
        
        .text-card {
            background-color: white;
            border-radius: 12px;
            padding: 16px 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
            height: auto; /* 高度自适应内容 */
            display: flex;
            flex-direction: column;
            justify-content: center; /* 内容垂直居中 */
        }
        
        .card-accent {
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
        }
        
        .accent-blue {
            background: linear-gradient(180deg, #0A5D94 0%, #3A9C6C 100%);
        }
        
        .accent-green {
            background: linear-gradient(180deg, #3A9C6C 0%, #0A5D94 100%);
        }
        
        .section-title {
            font-size: 24px;
            font-weight: bold;
            color: #0A5D94;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
        }
        
        .section-icon {
            margin-right: 10px;
            width: 30px;
            height: 30px;
            background-color: rgba(10, 93, 148, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #0A5D94;
            font-size: 15px;
        }
        
        .section-subtitle {
            font-size: 20px;
            font-weight: 600;
            color: #3A9C6C;
            margin-bottom: 8px;
            margin-top: 10px;
            padding-left: 40px;
        }
        
        .text-content {
            font-size: 18px;
            line-height: 1.5;
            color: #444;
        }
        
        .text-content p {
            margin-bottom: 8px;
        }
        
        ul.bullet-list {
            list-style: none;
            padding-left: 5px;
            margin-top: 8px;
        }
        
        ul.bullet-list li {
            position: relative;
            margin-bottom: 6px;
            padding-left: 24px;
            font-size: 18px;
        }
        
        ul.bullet-list li::before {
            content: "";
            position: absolute;
            left: 0;
            top: 9px;
            width: 9px;
            height: 9px;
            border-radius: 50%;
            background-color: #0A5D94;
        }
        
        ul.bullet-list li ul.sub-bullet-list {
            list-style: none;
            padding-left: 5px;
            margin-top: 5px;
        }
        
        ul.bullet-list li ul.sub-bullet-list li {
            padding-left: 22px;
            margin-bottom: 5px;
            font-size: 17px;
        }
        
        ul.bullet-list li ul.sub-bullet-list li::before {
            background-color: #3A9C6C;
            width: 7px;
            height: 7px;
            top: 9px;
        }
        
        .highlight {
            color: #E57373;
            font-weight: bold;
        }
        
        .decoration-circle {
            position: absolute;
            border-radius: 50%;
            z-index: 0;
            opacity: 0.4;
        }
        
        .circle-1 {
            bottom: -100px;
            right: -50px;
            width: 200px;
            height: 200px;
            background: radial-gradient(circle, rgba(58,156,108,0.1) 0%, rgba(10,93,148,0.05) 100%);
        }
        
        .circle-2 {
            top: 20%;
            left: -80px;
            width: 150px;
            height: 150px;
            background: radial-gradient(circle, rgba(10,93,148,0.1) 0%, rgba(58,156,108,0.05) 100%);
        }
        
        .circle-3 {
            top: 40%;
            right: 30%;
            width: 80px;
            height: 80px;
            background: radial-gradient(circle, rgba(58,156,108,0.08) 0%, rgba(10,93,148,0.04) 100%);
        }
        
        .formula {
            font-family: "Times New Roman", Times, serif;
            font-style: italic;
            background-color: rgba(10, 93, 148, 0.1);
            padding: 5px 10px;
            border-radius: 5px;
            display: inline-block;
            margin: 5px 0;
        }
    </style>
</head>
<body>
    <div class="slide-container">
        <!-- 顶部装饰条 -->
        <div class="header">
            <div class="header-content">
                <div>
                    <i class="fas fa-sun header-icon"></i>
                    <span>光学现象研究</span>
                </div>
            </div>
        </div>
        
        <!-- 内容区域 -->
        <div class="content">
            <div class="title-section">
                <h1 class="title">瑞利散射原理</h1>
                <h2 class="subtitle">天空为什么是蓝色的科学解释</h2>
            </div>
            
            <div class="content-wrapper">
                <div class="content-column">
                    <div class="text-card">
                        <div class="card-accent accent-blue"></div>
                        <h3 class="section-title">
                            <div class="section-icon"><i class="fas fa-atom"></i></div>
                            瑞利散射的基本原理
                        </h3>
                        
                        <div class="text-content">
                            <p>当太阳光进入地球大气层时，会与空气中的分子（如氮气、氧气）发生相互作用。由于这些分子的尺寸远小于可见光的波长（约1/10以下），光的散射强度与波长的四次方成反比。</p>
                            
                            <div class="formula">
                                I ∝ 1/λ⁴
                            </div>
                            
                            <ul class="bullet-list">
                                <li>这意味着波长越短的光，散射越强烈</li>
                                <li>蓝光的波长(约450nm)比红光(约650nm)短
                                    <ul class="sub-bullet-list">
                                        <li>蓝光散射强度约为红光的(650/450)⁴≈4.3倍</li>
                                        <li>因此天空呈现蓝色</li>
                                    </ul>
                                </li>
                                <li>日落时太阳呈红色是因为蓝光被大量散射</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="content-column">
                    <div class="text-card">
                        <div class="card-accent accent-green"></div>
                        <h3 class="section-title">
                            <div class="section-icon"><i class="fas fa-cloud-sun"></i></div>
                            散射现象的应用
                        </h3>
                        
                        <h4 class="section-subtitle">大气光学与日常现象</h4>
                        
                        <div class="text-content">
                            <p>瑞利散射不仅解释了天空的颜色，还帮助我们理解许多其他自然现象。</p>
                            
                            <ul class="bullet-list">
                                <li>解释了为什么<span class="highlight">晴朗天空呈现蓝色</span></li>
                                <li>说明了为什么日出日落时太阳呈现红色</li>
                                <li>解释了为什么太空中的天空是黑色的
                                    <ul class="sub-bullet-list">
                                        <li>太空中没有大气分子散射阳光</li>
                                        <li>光线直接传播，不被散射</li>
                                    </ul>
                                </li>
                                <li>应用于大气污染监测</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 装饰圆形 -->
            <div class="decoration-circle circle-1"></div>
            <div class="decoration-circle circle-2"></div>
            <div class="decoration-circle circle-3"></div>
        </div>
    </div>
</body>
</html>

第5页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>可见光波长与散射分析</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
    <script src="https://s3.ssl.qhres2.com/static/e4b726ed78536682.js"></script>
    <script src="https://s4.ssl.qhres2.com/static/61de9e120ef01fda.js"></script>

    <style>
        @font-face {
            font-family: 'Source Han Sans CN';
            src: local('Source Han Sans CN'), local('思源黑体');
        }
        
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "Source Han Sans CN", sans-serif;
        }
        
        .slide-container {
            width: 100vw;
            height: 100vh;
            background-color: #F9FBFC;
            position: relative;
            overflow: hidden;
        }
        
        .header {
            height: 80px;
            background-color: #1A7BB7;
            color: white;
            padding: 0 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
            overflow: hidden;
        }
        
        .header::after {
            content: "";
            position: absolute;
            bottom: 0;
            right: 0;
            width: 300px;
            height: 80px;
            background: linear-gradient(90deg, rgba(26, 123, 183, 0) 0%, rgba(76, 175, 120, 0.3) 100%);
            z-index: 1;
        }
        
        .header-title {
            font-size: 32px;
            font-weight: bold;
            z-index: 2;
        }
        
        .header-subtitle {
            font-size: 18px;
            opacity: 0.9;
            z-index: 2;
        }
        
        .content {
            display: flex;
            height: calc(100% - 80px);
            padding: 20px;
        }
        
        .chart-container {
            flex: 1;
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .chart-box {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            padding: 15px;
            position: relative;
            overflow: hidden;
        }
        
        .chart-box::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background-color: #1A7BB7;
        }
        
        .chart-box.highlight::after {
            background-color: #4CAF78;
        }
        
        .chart-box.warning::after {
            background-color: #E57373;
        }
        
        .chart-title {
            font-size: 18px;
            font-weight: bold;
            color: #607D8B;
            margin-bottom: 10px;
            padding-left: 10px;
            display: flex;
            align-items: center;
        }
        
        .chart-title i {
            margin-right: 8px;
            color: #1A7BB7;
        }
        
        .chart {
            width: 100%;
            height: calc(100% - 30px);
        }
        
        .chart-box-large {
            width: calc(50% - 10px);
            height: calc(50% - 10px);
        }
        
        .chart-box-small {
            width: calc(25% - 15px);
            height: calc(50% - 10px);
        }
        
        .chart-note {
            position: absolute;
            bottom: 5px;
            right: 10px;
            font-size: 12px;
            color: #607D8B;
            font-style: italic;
        }
        
        .dna-decoration {
            position: absolute;
            bottom: 10px;
            right: 10px;
            width: 150px;
            height: 60px;
            opacity: 0.1;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 40"><path d="M0,20 Q25,0 50,20 T100,20" fill="none" stroke="%231A7BB7" stroke-width="2"/><path d="M0,20 Q25,40 50,20 T100,20" fill="none" stroke="%231A7BB7" stroke-width="2"/></svg>');
            background-repeat: repeat-x;
            z-index: 0;
        }
        
        .heartbeat-line {
            position: absolute;
            top: 20px;
            right: 40px;
            width: 100px;
            height: 40px;
            opacity: 0.6;
            z-index: 2;
        }
        
        .heartbeat-line svg {
            width: 100%;
            height: 100%;
        }
        
        .grid-bg {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: linear-gradient(rgba(96, 125, 139, 0.05) 1px, transparent 1px), 
                              linear-gradient(90deg, rgba(96, 125, 139, 0.05) 1px, transparent 1px);
            background-size: 20px 20px;
            z-index: 0;
        }
        
        .info-box {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .info-title {
            font-size: 20px;
            font-weight: bold;
            color: #1A7BB7;
            margin-bottom: 15px;
            border-bottom: 2px solid #1A7BB7;
            padding-bottom: 5px;
        }
        
        .info-content {
            font-size: 16px;
            line-height: 1.6;
            color: #607D8B;
        }
        
        .math-formula {
            background-color: #f5f5f5;
            border-radius: 5px;
            padding: 10px;
            font-family: monospace;
            margin: 10px 0;
            display: inline-block;
        }
        
        .wavelength-scale {
            display: flex;
            height: 30px;
            margin: 20px 0;
            border-radius: 5px;
            overflow: hidden;
        }
        
        .wavelength-segment {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 12px;
        }
        
        .wavelength-segment.purple { background-color: #8A2BE2; }
        .wavelength-segment.blue { background-color: #1E90FF; }
        .wavelength-segment.green { background-color: #32CD32; }
        .wavelength-segment.yellow { background-color: #FFD700; }
        .wavelength-segment.orange { background-color: #FF8C00; }
        .wavelength-segment.red { background-color: #FF4500; }
    </style>
</head>
<body>
    <div class="slide-container">
        <div class="grid-bg"></div>
        <div class="header">
            <div>
                <div class="header-title">可见光波长与散射分析</div>
                <div class="header-subtitle">波长范围与散射强度对比研究</div>
            </div>
            <div class="heartbeat-line">
                <svg viewBox="0 0 100 20">
                    <path d="M0,10 L10,10 L15,2 L20,18 L25,0 L30,10 L40,10 L45,5 L50,15 L55,10 L70,10 L75,5 L80,10 L100,10" 
                          fill="none" stroke="white" stroke-width="1.5"/>
                </svg>
            </div>
        </div>
        <div class="content">
            <div class="chart-container">
                <div class="chart-box chart-box-large">
                    <div class="chart-title">
                        <i class="fas fa-wave-square"></i>可见光波长范围
                    </div>
                    <div class="info-box">
                        <div class="wavelength-scale">
                            <div class="wavelength-segment purple" style="flex: 0.7;">380-450nm<br>紫色</div>
                            <div class="wavelength-segment blue" style="flex: 0.45;">450-495nm<br>蓝色</div>
                            <div class="wavelength-segment green" style="flex: 0.75;">495-570nm<br>绿色</div>
                            <div class="wavelength-segment yellow" style="flex: 0.5;">570-590nm<br>黄色</div>
                            <div class="wavelength-segment orange" style="flex: 0.3;">590-620nm<br>橙色</div>
                            <div class="wavelength-segment red" style="flex: 1.3;">620-750nm<br>红色</div>
                        </div>
                        <div class="info-content">
                            可见光波长范围从紫色(约380-450nm)到红色(620-750nm)，中间依次为蓝色(450-495nm)、绿色(495-570nm)、黄色(570-590nm)和橙色(590-620nm)。
                        </div>
                    </div>
                </div>
                <div class="chart-box chart-box-large highlight">
                    <div class="chart-title">
                        <i class="fas fa-atom"></i>散射强度对比
                    </div>
                    <div class="info-box">
                        <div class="info-title">瑞利散射定律</div>
                        <div class="info-content">
                            根据瑞利散射定律，散射强度与波长的四次方成反比：
                            <div class="math-formula">
                                散射强度 ∝ 1/λ⁴
                            </div>
                            这意味着波长越短的光，散射强度越大。
                        </div>
                        <div class="info-title">蓝光与红光散射对比</div>
                        <div class="info-content">
                            蓝光(450nm)的散射强度约为红光(650nm)的：
                            <div class="math-formula">
                                (650/450)⁴ ≈ 4.3倍
                            </div>
                            这就是为什么天空呈现蓝色的原因 - 太阳光中的蓝光比其他颜色的光散射得更强烈。
                        </div>
                    </div>
                </div>
                <div class="chart-box chart-box-small">
                    <div class="chart-title">
                        <i class="fas fa-sun"></i>可见光谱
                    </div>
                    <div id="spectrumChart" class="chart"></div>
                </div>
                <div class="chart-box chart-box-small warning">
                    <div class="chart-title">
                        <i class="fas fa-exclamation-triangle"></i>紫外线警告
                    </div>
                    <div class="info-content" style="padding: 15px;">
                        紫外线(10-400nm)波长比紫色光更短，具有更强的散射和更高的能量，可能对生物组织造成伤害。
                    </div>
                </div>
                <div class="chart-box chart-box-small">
                    <div class="chart-title">
                        <i class="fas fa-cloud-sun"></i>天空颜色解释
                    </div>
                    <div class="info-content" style="padding: 15px;">
                        白天天空呈现蓝色是因为蓝光散射最强，而日出日落时呈现红色是因为太阳光穿过更厚的大气层，蓝光被散射掉，剩下红光直接到达观察者。
                    </div>
                </div>
                <div class="chart-box chart-box-small">
                    <div class="chart-title">
                        <i class="fas fa-question-circle"></i>常见问题
                    </div>
                    <div class="info-content" style="padding: 15px;">
                        Q: 为什么云是白色的？<br>
                        A: 云中的水滴较大，对所有波长的光都散射(米氏散射)，因此看起来是白色。
                    </div>
                </div>
            </div>
        </div>
        <div class="dna-decoration"></div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 光谱图
            const spectrumChart = echarts.init(document.getElementById('spectrumChart'));
            const spectrumOption = {
                color: ['#8A2BE2', '#1E90FF', '#32CD32', '#FFD700', '#FF8C00', '#FF4500'],
                xAxis: {
                    type: 'value',
                    min: 380,
                    max: 750,
                    axisLabel: {
                        formatter: '{value}nm'
                    },
                    axisLine: {
                        lineStyle: {
                            color: '#607D8B'
                        }
                    }
                },
                yAxis: {
                    show: false
                },
                series: [{
                    type: 'line',
                    showSymbol: false,
                    data: [
                        [380, 0], [450, 1], [450, 0],
                        [450, 0], [495, 1], [495, 0],
                        [495, 0], [570, 1], [570, 0],
                        [570, 0], [590, 1], [590, 0],
                        [590, 0], [620, 1], [620, 0],
                        [620, 0], [750, 1], [750, 0]
                    ],
                    lineStyle: {
                        width: 10,
                        color: {
                            type: 'linear',
                            x: 0,
                            y: 0,
                            x2: 1,
                            y2: 0,
                            colorStops: [
                                { offset: 0, color: '#8A2BE2' },
                                { offset: 0.15, color: '#1E90FF' },
                                { offset: 0.35, color: '#32CD32' },
                                { offset: 0.45, color: '#FFD700' },
                                { offset: 0.5, color: '#FF8C00' },
                                { offset: 0.6, color: '#FF4500' },
                                { offset: 1, color: '#FF4500' }
                            ]
                        }
                    }
                }],
                grid: {
                    left: '5%',
                    right: '5%',
                    top: '5%',
                    bottom: '5%'
                }
            };
            spectrumChart.setOption(spectrumOption);

            // 窗口大小变化时重新调整图表大小
            window.addEventListener('resize', function() {
                spectrumChart.resize();
            });
        });
    </script>
</body>
</html>

第6页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>瑞利散射分析报告</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
        <script src="https://s3.ssl.qhres2.com/static/e4b726ed78536682.js"></script>
<script src="https://s4.ssl.qhres2.com/static/61de9e120ef01fda.js"></script>

    <style>
        @font-face {
            font-family: 'Source Han Sans CN';
            src: local('Source Han Sans CN'), local('思源黑体');
            font-weight: normal;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body, html {
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "思源黑体", "Source Han Sans CN", sans-serif;
            background-color: #F9FBFC;
        }
        
        .slide-container {
            width: 100%;
            height: 100%;
            position: relative;
            background-color: #F9FBFC;
            overflow: hidden;
        }
        
        .header {
            height: 80px;
            background-color: #1A7BB7;
            color: white;
            padding: 0 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
            overflow: hidden;
        }
        
        .header::after {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 300px;
            height: 100%;
            background: linear-gradient(90deg, rgba(26, 123, 183, 0) 0%, rgba(76, 175, 120, 0.3) 100%);
            z-index: 1;
        }
        
        .header-title {
            font-size: 32px;
            font-weight: bold;
            z-index: 2;
        }
        
        .header-decoration {
            position: absolute;
            right: 60px;
            top: 50%;
            transform: translateY(-50%);
            z-index: 2;
        }
        
        .content {
            display: flex;
            height: calc(100% - 80px);
            padding: 20px;
            align-items: center; /* 添加垂直居中 */
        }
        
        .image-container {
            flex: 3;
            padding: 20px;
            display: flex;
            flex-direction: column;
            position: relative;
        }
        
        .image-display {
            flex: 1;
            background-color: #000;
            border-radius: 10px;
            overflow: hidden;
            position: relative;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        
        .medical-image {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }
        
        .image-overlay {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: rgba(0, 0, 0, 0.6);
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .image-markers {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
        }
        
        .marker {
            position: absolute;
            width: 24px;
            height: 24px;
            transform: translate(-50%, -50%);
            color: #E57373;
            filter: drop-shadow(0 0 2px rgba(255, 255, 255, 0.8));
        }
        
        .info-container {
            flex: 2;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        
        .info-section {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        
        .section-title {
            font-size: 22px;
            font-weight: bold;
            color: #1A7BB7;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-content {
            font-size: 16px;
            color: #607D8B;
            line-height: 1.6;
        }
        
        .findings-list {
            list-style-type: none;
        }
        
        .findings-list li {
            margin-bottom: 10px;
            padding-left: 25px;
            position: relative;
        }
        
        .findings-list li::before {
            content: '\f058';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            left: 0;
            color: #4CAF78;
        }
        
        .critical-finding {
            color: #E57373;
            font-weight: bold;
        }
        
        .critical-finding::before {
            content: '\f071';
            color: #E57373;
        }
        
        .chart-container {
            height: 200px;
            margin-top: 10px;
        }
        
        .background-decoration {
            position: absolute;
            bottom: -100px;
            right: -100px;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(76, 175, 120, 0.1) 0%, rgba(249, 251, 252, 0) 70%);
            border-radius: 50%;
            z-index: -1;
        }
        
        .dna-decoration {
            position: absolute;
            bottom: 20px;
            left: 20px;
            opacity: 0.1;
            font-size: 60px;
            color: #1A7BB7;
            z-index: -1;
        }
        
        .heartbeat-line {
            position: absolute;
            bottom: 10px;
            right: 20px;
            height: 30px;
            width: 150px;
            z-index: 2;
        }
    </style>
</head>
<body>
    <div class="slide-container">
        <!-- Header -->
        <div class="header">
            <div class="header-title">瑞利散射分析报告</div>
            <div class="header-decoration">
                <i class="fas fa-sun fa-2x"></i>
            </div>
        </div>
        
        <!-- Content -->
        <div class="content">
            <!-- Left: Image Display -->
            <div class="image-container">
                <div class="image-display">
                    <img src="http://hyperphysics.phy-astr.gsu.edu/hbase/atmos/imgatm/rayle.png" alt="瑞利散射示意图" class="medical-image">
                    <div class="image-overlay">瑞利散射示意图</div>
                    <div class="image-markers">
                        <i class="fas fa-crosshairs marker" style="top: 45%; left: 30%; color: #4CAF78;"></i>
                        <i class="fas fa-crosshairs marker" style="top: 60%; left: 70%; color: #1A7BB7;"></i>
                    </div>
                </div>
            </div>
            
            <!-- Right: Information -->
            <div class="info-container">
                <div class="info-section">
                    <div class="section-title">
                        <i class="fas fa-clipboard-list"></i>
                        基本概念
                    </div>
                    <div class="section-content">
                        <p><strong>现象：</strong>瑞利散射</p>
                        <p><strong>发现者：</strong>约翰·威廉·斯特拉特，第三代瑞利男爵</p>
                        <p><strong>原理：</strong>光通过比其波长小的颗粒时发生的散射</p>
                        <p><strong>特点：</strong>散射强度与波长的四次方成反比</p>
                    </div>
                </div>
                
                <div class="info-section">
                    <div class="section-title">
                        <i class="fas fa-search-plus"></i>
                        关键发现
                    </div>
                    <div class="section-content">
                        <ul class="findings-list">
                            <li>短波长光（蓝/紫）向各个方向散射更显著</li>
                            <li>长波长光（红/橙）更容易直接穿透</li>
                            <li class="critical-finding">散射强度与波长的四次方成反比</li>
                            <li>解释了天空呈现蓝色的原因</li>
                            <li>日落时太阳呈现红色的原因</li>
                        </ul>
                    </div>
                </div>
                
                <div class="info-section">
                    <div class="section-title">
                        <i class="fas fa-chart-line"></i>
                        波长散射强度分析
                    </div>
                    <div class="section-content">
                        <p>不同波长光的散射强度对比</p>
                        <div id="densityChart" class="chart-container"></div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Background Decorations -->
        <div class="background-decoration"></div>
        <i class="fas fa-atom dna-decoration"></i>
        
        <svg class="heartbeat-line" viewBox="0 0 200 30" xmlns="http://www.w3.org/2000/svg">
            <path d="M0,15 L20,15 L30,5 L40,25 L50,5 L60,15 L80,15 L90,10 L100,20 L110,10 L120,15 L140,15 L150,5 L160,25 L170,15 L200,15" 
                  stroke="#1A7BB7" 
                  stroke-width="2" 
                  fill="none" />
        </svg>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 初始化密度分析图表
            const densityChart = echarts.init(document.getElementById('densityChart'));
            
            const option = {
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '10%',
                    top: '10%',
                    containLabel: true
                },
                xAxis: {
                    type: 'category',
                    data: ['紫光(400nm)', '蓝光(450nm)', '绿光(550nm)', '黄光(600nm)', '红光(700nm)'],
                    axisLabel: {
                        color: '#607D8B',
                        rotate: 30
                    }
                },
                yAxis: {
                    type: 'value',
                    name: '散射强度',
                    axisLabel: {
                        color: '#607D8B'
                    }
                },
                series: [
                    {
                        data: [390, 240, 110, 77, 42],
                        type: 'bar',
                        itemStyle: {
                            color: function(params) {
                                const colorList = ['#8A2BE2', '#1E90FF', '#32CD32', '#FFD700', '#FF4500'];
                                return colorList[params.dataIndex];
                            }
                        }
                    },
                    {
                        data: [390, 240, 110, 77, 42],
                        type: 'line',
                        smooth: true,
                        symbol: 'circle',
                        symbolSize: 8,
                        lineStyle: {
                            color: '#1A7BB7',
                            width: 2
                        },
                        itemStyle: {
                            color: '#1A7BB7'
                        }
                    }
                ],
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    },
                    formatter: function(params) {
                        return params[0].name + '<br/>散射强度: ' + params[0].value;
                    }
                }
            };
            
            densityChart.setOption(option);
            
            // 响应窗口大小变化
            window.addEventListener('resize', function() {
                densityChart.resize();
            });
        });
    </script>
</body>
</html>

第7页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>为何是蓝色而非紫色</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "思源黑体", sans-serif;
        }
        
        .slide-container {
            width: 100%;
            height: 100vh;
            display: flex;
            background-color: #F9FBFC;
            position: relative;
        }
        
        .left-bar {
            width: 120px;
            height: 100%;
            background-color: #1A7BB7;
            position: relative;
            overflow: hidden;
        }
        
        .left-bar::before {
            content: "";
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background-color: rgba(76, 175, 120, 0.2);
            top: -100px;
            left: -150px;
        }
        
        .left-bar::after {
            content: "";
            position: absolute;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background-color: rgba(76, 175, 120, 0.15);
            bottom: -50px;
            left: -100px;
        }
        
        .content {
            flex: 1;
            padding: 60px 80px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .chapter-title {
            font-size: 48px;
            font-weight: bold;
            color: #1A7BB7;
            margin-bottom: 30px;
        }
        
        .chapter-description {
            font-size: 24px;
            color: #607D8B;
            max-width: 700px;
            line-height: 1.6;
        }
        
        .medical-icon {
            position: absolute;
            right: 60px;
            bottom: 60px;
            font-size: 150px;
            color: rgba(26, 123, 183, 0.1);
        }
        
        .dna-decoration {
            position: absolute;
            top: 40px;
            right: 40px;
            width: 220px;
            height: 100px;
        }
        
        .heartbeat-line {
            position: absolute;
            bottom: 30px;
            left: 150px;
            width: 350px;
            height: 50px;
            opacity: 0.2;
        }
    </style>
</head>
<body>
    <div class="slide-container">
        <div class="left-bar"></div>
        <div class="content">
            <h1 class="chapter-title">为何是蓝色而非紫色</h1>
            <p class="chapter-description">
                本章节将探讨医疗领域中蓝色作为主色调的科学依据和心理效应，
                分析为何蓝色比紫色更适合医疗环境，以及这种选择对患者和医护人员的潜在影响。
            </p>
        </div>
        
        <div class="medical-icon">
            <i class="fas fa-question-circle"></i>
        </div>
        
        <svg class="dna-decoration" viewBox="0 0 100 40" xmlns="http://www.w3.org/2000/svg">
            <path d="M10,20 Q25,5 40,20 T70,20 T100,20" stroke="#1A7BB7" stroke-width="1" fill="none" opacity="0.3"/>
            <path d="M10,20 Q25,35 40,20 T70,20 T100,20" stroke="#1A7BB7" stroke-width="1" fill="none" opacity="0.3"/>
            <circle cx="10" cy="20" r="2" fill="#4CAF78" opacity="0.5"/>
            <circle cx="40" cy="20" r="2" fill="#4CAF78" opacity="0.5"/>
            <circle cx="70" cy="20" r="2" fill="#4CAF78" opacity="0.5"/>
            <circle cx="100" cy="20" r="2" fill="#4CAF78" opacity="0.5"/>
            <circle cx="25" cy="12.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="25" cy="27.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="55" cy="12.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="55" cy="27.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="85" cy="12.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="85" cy="27.5" r="1.5" fill="#E57373" opacity="0.5"/>
        </svg>
        
        <svg class="heartbeat-line" viewBox="0 0 100 20" xmlns="http://www.w3.org/2000/svg">
            <path d="M0,10 L10,10 L15,3 L25,17 L35,3 L45,17 L50,10 L60,10 L65,5 L70,15 L75,5 L85,10 L100,10" 
                  stroke="#1A7BB7" 
                  stroke-width="1.5" 
                  fill="none"/>
        </svg>
    </div>
</body>
</html>

第8页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>科学现象解析 - 天空为什么是蓝色的</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body, html {
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "思源黑体", sans-serif;
            background-color: #F5F9FC;
        }
        
        .slide-container {
            width: 100%;
            height: 100%;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        
        .header {
            height: 60px;
            background: linear-gradient(90deg, #0A5D94 0%, #3A9C6C 100%);
            position: relative;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            z-index: 10;
        }
        
        .header::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><path d="M0,50 Q25,25 50,50 T100,50" fill="none" stroke="rgba(255,255,255,0.15)" stroke-width="2" /></svg>');
            background-size: 100px 100px;
            opacity: 0.5;
        }
        
        .header-content {
            padding: 0 40px;
            height: 100%;
            color: white;
            position: relative;
            z-index: 2;
            font-size: 18px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .header-icon {
            margin-right: 15px;
            font-size: 22px;
            color: rgba(255,255,255,0.9);
        }
        
        .content {
            flex: 1;
            position: relative;
            background-color: #F5F9FC;
            display: flex;
            flex-direction: column;
            padding: 15px 30px 20px;
        }
        
        .title-section {
            margin-bottom: 15px;
            position: relative;
        }
        
        .title {
            font-size: 36px;
            font-weight: bold;
            color: #0A5D94;
            margin-bottom: 8px;
            position: relative;
            display: inline-block;
        }
        
        .title::after {
            content: "";
            position: absolute;
            bottom: -6px;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #0A5D94 0%, #3A9C6C 100%);
            border-radius: 2px;
        }
        
        .subtitle {
            font-size: 24px;
            color: #607D8B;
            font-weight: 500;
        }
        
        .content-wrapper {
            display: flex;
            justify-content: center; /* 水平居中 */
            align-items: center; /* 垂直居中 */
            gap: 20px;
            flex: 1;
        }
        
        .content-column {
            flex: 0 1 auto; /* 不强制拉伸，根据内容自适应宽度 */
            max-width: 45%; /* 限制最大宽度 */
            display: flex;
            flex-direction: column;
            justify-content: center; /* 垂直居中 */
        }
        
        .text-card {
            background-color: white;
            border-radius: 12px;
            padding: 16px 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
            height: auto; /* 高度自适应内容 */
            display: flex;
            flex-direction: column;
            justify-content: center; /* 内容垂直居中 */
        }
        
        .card-accent {
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
        }
        
        .accent-blue {
            background: linear-gradient(180deg, #0A5D94 0%, #3A9C6C 100%);
        }
        
        .accent-green {
            background: linear-gradient(180deg, #3A9C6C 0%, #0A5D94 100%);
        }
        
        .section-title {
            font-size: 24px;
            font-weight: bold;
            color: #0A5D94;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
        }
        
        .section-icon {
            margin-right: 10px;
            width: 30px;
            height: 30px;
            background-color: rgba(10, 93, 148, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #0A5D94;
            font-size: 15px;
        }
        
        .section-subtitle {
            font-size: 20px;
            font-weight: 600;
            color: #3A9C6C;
            margin-bottom: 8px;
            margin-top: 10px;
            padding-left: 40px;
        }
        
        .text-content {
            font-size: 18px;
            line-height: 1.5;
            color: #444;
        }
        
        .text-content p {
            margin-bottom: 8px;
        }
        
        ul.bullet-list {
            list-style: none;
            padding-left: 5px;
            margin-top: 8px;
        }
        
        ul.bullet-list li {
            position: relative;
            margin-bottom: 6px;
            padding-left: 24px;
            font-size: 18px;
        }
        
        ul.bullet-list li::before {
            content: "";
            position: absolute;
            left: 0;
            top: 9px;
            width: 9px;
            height: 9px;
            border-radius: 50%;
            background-color: #0A5D94;
        }
        
        ul.bullet-list li ul.sub-bullet-list {
            list-style: none;
            padding-left: 5px;
            margin-top: 5px;
        }
        
        ul.bullet-list li ul.sub-bullet-list li {
            padding-left: 22px;
            margin-bottom: 5px;
            font-size: 17px;
        }
        
        ul.bullet-list li ul.sub-bullet-list li::before {
            background-color: #3A9C6C;
            width: 7px;
            height: 7px;
            top: 9px;
        }
        
        .highlight {
            color: #E57373;
            font-weight: bold;
        }
        
        .decoration-circle {
            position: absolute;
            border-radius: 50%;
            z-index: 0;
            opacity: 0.4;
        }
        
        .circle-1 {
            bottom: -100px;
            right: -50px;
            width: 200px;
            height: 200px;
            background: radial-gradient(circle, rgba(58,156,108,0.1) 0%, rgba(10,93,148,0.05) 100%);
        }
        
        .circle-2 {
            top: 20%;
            left: -80px;
            width: 150px;
            height: 150px;
            background: radial-gradient(circle, rgba(10,93,148,0.1) 0%, rgba(58,156,108,0.05) 100%);
        }
        
        .circle-3 {
            top: 40%;
            right: 30%;
            width: 80px;
            height: 80px;
            background: radial-gradient(circle, rgba(58,156,108,0.08) 0%, rgba(10,93,148,0.04) 100%);
        }
    </style>
</head>
<body>
    <div class="slide-container">
        <!-- 顶部装饰条 -->
        <div class="header">
            <div class="header-content">
                <div>
                    <i class="fas fa-cloud header-icon"></i>
                    <span>自然科学探索</span>
                </div>
            </div>
        </div>
        
        <!-- 内容区域 -->
        <div class="content">
            <div class="title-section">
                <h1 class="title">天空为什么呈现蓝色</h1>
                <h2 class="subtitle">瑞利散射与人类视觉的奇妙结合</h2>
            </div>
            
            <div class="content-wrapper">
                <div class="content-column">
                    <div class="text-card">
                        <div class="card-accent accent-blue"></div>
                        <h3 class="section-title">
                            <div class="section-icon"><i class="fas fa-eye"></i></div>
                            现象解析
                        </h3>
                        
                        <div class="text-content">
                            <p>尽管紫色光波长更短、散射更强，但天空实际呈现蓝色而非紫色，这一现象可以从多个科学角度进行解释。</p>
                            
                            <ul class="bullet-list">
                                <li>太阳光穿过大气层时发生瑞利散射
                                    <ul class="sub-bullet-list">
                                        <li>短波长的光比长波长的光散射更强</li>
                                        <li>理论上紫色光散射最强</li>
                                    </ul>
                                </li>
                                <li>实际观察到的天空呈现蓝色而非紫色</li>
                                <li>这一现象涉及多个科学原理的综合作用</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="content-column">
                    <div class="text-card">
                        <div class="card-accent accent-green"></div>
                        <h3 class="section-title">
                            <div class="section-icon"><i class="fas fa-lightbulb"></i></div>
                            主要原因
                        </h3>
                        
                        <h4 class="section-subtitle">三大关键因素</h4>
                        
                        <div class="text-content">
                            <p>天空呈现蓝色而非紫色的主要原因可以归纳为以下三点：</p>
                            
                            <ul class="bullet-list">
                                <li>人眼对颜色的敏感度
                                    <ul class="sub-bullet-list">
                                        <li>视网膜对蓝光(450nm附近)敏感度更高</li>
                                        <li>对紫色光(400nm以下)敏感度较低</li>
                                    </ul>
                                </li>
                                <li>太阳光谱能量分布
                                    <ul class="sub-bullet-list">
                                        <li>蓝光区域能量强度更高</li>
                                        <li>紫外和紫色光区域能量相对较弱</li>
                                    </ul>
                                </li>
                                <li>高层大气吸收
                                    <ul class="sub-bullet-list">
                                        <li>臭氧层吸收部分紫色光</li>
                                        <li>进一步减少紫色光的可见度</li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 装饰圆形 -->
            <div class="decoration-circle circle-1"></div>
            <div class="decoration-circle circle-2"></div>
            <div class="decoration-circle circle-3"></div>
        </div>
    </div>
</body>
</html>

第9页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>日出日落时的红色天空</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "思源黑体", sans-serif;
        }
        
        .slide-container {
            width: 100%;
            height: 100vh;
            display: flex;
            background-color: #F9FBFC;
            position: relative;
        }
        
        .left-bar {
            width: 120px;
            height: 100%;
            background-color: #E57373;
            position: relative;
            overflow: hidden;
        }
        
        .left-bar::before {
            content: "";
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background-color: rgba(229, 115, 115, 0.2);
            top: -100px;
            left: -150px;
        }
        
        .left-bar::after {
            content: "";
            position: absolute;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background-color: rgba(229, 115, 115, 0.15);
            bottom: -50px;
            left: -100px;
        }
        
        .content {
            flex: 1;
            padding: 60px 80px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .chapter-title {
            font-size: 48px;
            font-weight: bold;
            color: #E57373;
            margin-bottom: 30px;
        }
        
        .chapter-description {
            font-size: 24px;
            color: #607D8B;
            max-width: 700px;
            line-height: 1.6;
        }
        
        .sun-icon {
            position: absolute;
            right: 60px;
            bottom: 60px;
            font-size: 150px;
            color: rgba(229, 115, 115, 0.1);
        }
        
        .cloud-decoration {
            position: absolute;
            top: 40px;
            right: 40px;
            width: 220px;
            height: 100px;
        }
        
        .horizon-line {
            position: absolute;
            bottom: 30px;
            left: 150px;
            width: 350px;
            height: 50px;
            opacity: 0.2;
        }
    </style>
</head>
<body>
    <div class="slide-container">
        <div class="left-bar"></div>
        <div class="content">
            <h1 class="chapter-title">日出日落时的红色天空</h1>
            <p class="chapter-description">
                日出和日落时分，天空常常呈现出美丽的红色。这种现象是由于太阳光穿过更厚的大气层时，蓝光被散射，而红光得以穿透，形成了壮观的红色天空景观。
            </p>
        </div>
        
        <div class="sun-icon">
            <i class="fas fa-sun"></i>
        </div>
        
        <svg class="cloud-decoration" viewBox="0 0 100 40" xmlns="http://www.w3.org/2000/svg">
            <path d="M10,25 Q15,15 25,15 Q30,5 40,10 Q50,5 60,15 Q70,15 75,25 Q85,25 90,20" 
                  stroke="#E57373" 
                  stroke-width="1" 
                  fill="none" 
                  opacity="0.3"/>
            <circle cx="20" cy="20" r="5" fill="#E57373" opacity="0.3"/>
            <circle cx="35" cy="15" r="7" fill="#E57373" opacity="0.3"/>
            <circle cx="50" cy="12" r="6" fill="#E57373" opacity="0.3"/>
            <circle cx="65" cy="18" r="8" fill="#E57373" opacity="0.3"/>
            <circle cx="80" cy="22" r="5" fill="#E57373" opacity="0.3"/>
        </svg>
        
        <svg class="horizon-line" viewBox="0 0 100 20" xmlns="http://www.w3.org/2000/svg">
            <path d="M0,15 L100,15" 
                  stroke="#E57373" 
                  stroke-width="1.5" 
                  fill="none"/>
            <path d="M20,10 L30,12 L40,8 L50,14 L60,9 L70,13 L80,11" 
                  stroke="#E57373" 
                  stroke-width="1" 
                  fill="none" 
                  opacity="0.5"/>
        </svg>
    </div>
</body>
</html>

第10页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>光学现象解析 - 日落色彩科学</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body, html {
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "思源黑体", sans-serif;
            background-color: #F5F9FC;
        }
        
        .slide-container {
            width: 100%;
            height: 100%;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        
        .header {
            height: 60px;
            background: linear-gradient(90deg, #0A5D94 0%, #3A9C6C 100%);
            position: relative;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            z-index: 10;
        }
        
        .header::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><path d="M0,50 Q25,25 50,50 T100,50" fill="none" stroke="rgba(255,255,255,0.15)" stroke-width="2" /></svg>');
            background-size: 100px 100px;
            opacity: 0.5;
        }
        
        .header-content {
            padding: 0 40px;
            height: 100%;
            color: white;
            position: relative;
            z-index: 2;
            font-size: 18px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .header-icon {
            margin-right: 15px;
            font-size: 22px;
            color: rgba(255,255,255,0.9);
        }
        
        .content {
            flex: 1;
            position: relative;
            background-color: #F5F9FC;
            display: flex;
            flex-direction: column;
            padding: 15px 30px 20px;
        }
        
        .title-section {
            margin-bottom: 15px;
            position: relative;
        }
        
        .title {
            font-size: 36px;
            font-weight: bold;
            color: #0A5D94;
            margin-bottom: 8px;
            position: relative;
            display: inline-block;
        }
        
        .title::after {
            content: "";
            position: absolute;
            bottom: -6px;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #0A5D94 0%, #3A9C6C 100%);
            border-radius: 2px;
        }
        
        .subtitle {
            font-size: 24px;
            color: #607D8B;
            font-weight: 500;
        }
        
        .content-wrapper {
            display: flex;
            justify-content: center; /* 水平居中 */
            align-items: center; /* 垂直居中 */
            gap: 20px;
            flex: 1;
        }
        
        .content-column {
            flex: 0 1 auto; /* 不强制拉伸，根据内容自适应宽度 */
            max-width: 45%; /* 限制最大宽度 */
            display: flex;
            flex-direction: column;
            justify-content: center; /* 垂直居中 */
        }
        
        .text-card {
            background-color: white;
            border-radius: 12px;
            padding: 16px 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
            height: auto; /* 高度自适应内容 */
            display: flex;
            flex-direction: column;
            justify-content: center; /* 内容垂直居中 */
        }
        
        .card-accent {
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
        }
        
        .accent-blue {
            background: linear-gradient(180deg, #0A5D94 0%, #3A9C6C 100%);
        }
        
        .accent-green {
            background: linear-gradient(180deg, #3A9C6C 0%, #0A5D94 100%);
        }
        
        .section-title {
            font-size: 24px;
            font-weight: bold;
            color: #0A5D94;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
        }
        
        .section-icon {
            margin-right: 10px;
            width: 30px;
            height: 30px;
            background-color: rgba(10, 93, 148, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #0A5D94;
            font-size: 15px;
        }
        
        .section-subtitle {
            font-size: 20px;
            font-weight: 600;
            color: #3A9C6C;
            margin-bottom: 8px;
            margin-top: 10px;
            padding-left: 40px;
        }
        
        .text-content {
            font-size: 18px;
            line-height: 1.5;
            color: #444;
        }
        
        .text-content p {
            margin-bottom: 8px;
        }
        
        ul.bullet-list {
            list-style: none;
            padding-left: 5px;
            margin-top: 8px;
        }
        
        ul.bullet-list li {
            position: relative;
            margin-bottom: 6px;
            padding-left: 24px;
            font-size: 18px;
        }
        
        ul.bullet-list li::before {
            content: "";
            position: absolute;
            left: 0;
            top: 9px;
            width: 9px;
            height: 9px;
            border-radius: 50%;
            background-color: #0A5D94;
        }
        
        ul.bullet-list li ul.sub-bullet-list {
            list-style: none;
            padding-left: 5px;
            margin-top: 5px;
        }
        
        ul.bullet-list li ul.sub-bullet-list li {
            padding-left: 22px;
            margin-bottom: 5px;
            font-size: 17px;
        }
        
        ul.bullet-list li ul.sub-bullet-list li::before {
            background-color: #3A9C6C;
            width: 7px;
            height: 7px;
            top: 9px;
        }
        
        .highlight {
            color: #E57373;
            font-weight: bold;
        }
        
        .decoration-circle {
            position: absolute;
            border-radius: 50%;
            z-index: 0;
            opacity: 0.4;
        }
        
        .circle-1 {
            bottom: -100px;
            right: -50px;
            width: 200px;
            height: 200px;
            background: radial-gradient(circle, rgba(58,156,108,0.1) 0%, rgba(10,93,148,0.05) 100%);
        }
        
        .circle-2 {
            top: 20%;
            left: -80px;
            width: 150px;
            height: 150px;
            background: radial-gradient(circle, rgba(10,93,148,0.1) 0%, rgba(58,156,108,0.05) 100%);
        }
        
        .circle-3 {
            top: 40%;
            right: 30%;
            width: 80px;
            height: 80px;
            background: radial-gradient(circle, rgba(58,156,108,0.08) 0%, rgba(10,93,148,0.04) 100%);
        }
    </style>
</head>
<body>
    <div class="slide-container">
        <!-- 顶部装饰条 -->
        <div class="header">
            <div class="header-content">
                <div>
                    <i class="fas fa-sun header-icon"></i>
                    <span>光学现象研究中心</span>
                </div>
                <!-- 页码已移除 -->
            </div>
        </div>
        
        <!-- 内容区域 -->
        <div class="content">
            <div class="title-section">
                <h1 class="title">日落色彩的科学解析</h1>
                <h2 class="subtitle">大气散射与光学现象</h2>
            </div>
            
            <div class="content-wrapper">
                <div class="content-column">
                    <div class="text-card">
                        <div class="card-accent accent-blue"></div>
                        <h3 class="section-title">
                            <div class="section-icon"><i class="fas fa-atom"></i></div>
                            日落色彩形成机制
                        </h3>
                        
                        <div class="text-content">
                            <p>当太阳处于地平线附近时，光线需穿过更厚的大气层（路径长度增加约10倍），导致短波长光（蓝/紫）几乎被完全散射到其他方向，仅剩长波长的红光和橙光主导视线。</p>
                            
                            <ul class="bullet-list">
                                <li>瑞利散射效应随路径长度指数增强
                                    <ul class="sub-bullet-list">
                                        <li>蓝光散射强度是红光的16倍</li>
                                        <li>大气层厚度增加导致散射累积效应</li>
                                    </ul>
                                </li>
                                <li>太阳高度角决定光线路径长度</li>
                                <li>大气成分影响散射光谱特征</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="content-column">
                    <div class="text-card">
                        <div class="card-accent accent-green"></div>
                        <h3 class="section-title">
                            <div class="section-icon"><i class="fas fa-cloud-sun"></i></div>
                            米氏散射的增强效应
                        </h3>
                        
                        <h4 class="section-subtitle">气溶胶颗粒的光学作用</h4>
                        
                        <div class="text-content">
                            <p>此时，米氏散射（Mie Scattering，对大颗粒如尘埃、水滴的散射）也可能增强，进一步强化暖色调。这种散射对所有波长光的作用相近，但会显著增强前向散射。</p>
                            
                            <ul class="bullet-list">
                                <li>气溶胶浓度与色彩饱和度呈<span class="highlight">正相关</span></li>
                                <li>火山喷发后常出现异常鲜艳日落
                                    <ul class="sub-bullet-list">
                                        <li>平流层硫酸盐颗粒增强散射</li>
                                        <li>1991年皮纳图博火山喷发案例</li>
                                    </ul>
                                </li>
                                <li>城市污染导致日落色彩变化</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 装饰圆形 -->
            <div class="decoration-circle circle-1"></div>
            <div class="decoration-circle circle-2"></div>
            <div class="decoration-circle circle-3"></div>
        </div>
    </div>
</body>
</html>

第11页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>大气光学现象分析报告</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
        <script src="https://s3.ssl.qhres2.com/static/e4b726ed78536682.js"></script>
<script src="https://s4.ssl.qhres2.com/static/61de9e120ef01fda.js"></script>

    <style>
        @font-face {
            font-family: 'Source Han Sans CN';
            src: local('Source Han Sans CN'), local('思源黑体');
            font-weight: normal;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body, html {
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "思源黑体", "Source Han Sans CN", sans-serif;
            background-color: #F9FBFC;
        }
        
        .slide-container {
            width: 100%;
            height: 100%;
            position: relative;
            background-color: #F9FBFC;
            overflow: hidden;
        }
        
        .header {
            height: 80px;
            background-color: #1A7BB7;
            color: white;
            padding: 0 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
            overflow: hidden;
        }
        
        .header::after {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 300px;
            height: 100%;
            background: linear-gradient(90deg, rgba(26, 123, 183, 0) 0%, rgba(76, 175, 120, 0.3) 100%);
            z-index: 1;
        }
        
        .header-title {
            font-size: 32px;
            font-weight: bold;
            z-index: 2;
        }
        
        .header-decoration {
            position: absolute;
            right: 60px;
            top: 50%;
            transform: translateY(-50%);
            z-index: 2;
        }
        
        .content {
            display: flex;
            height: calc(100% - 80px);
            padding: 20px;
            align-items: center; /* 添加垂直居中 */
        }
        
        .image-container {
            flex: 3;
            padding: 20px;
            display: flex;
            flex-direction: column;
            position: relative;
        }
        
        .image-display {
            flex: 1;
            background-color: #000;
            border-radius: 10px;
            overflow: hidden;
            position: relative;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        
        .medical-image {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }
        
        .image-overlay {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: rgba(0, 0, 0, 0.6);
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .image-markers {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
        }
        
        .marker {
            position: absolute;
            width: 24px;
            height: 24px;
            transform: translate(-50%, -50%);
            color: #E57373;
            filter: drop-shadow(0 0 2px rgba(255, 255, 255, 0.8));
        }
        
        .info-container {
            flex: 2;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        
        .info-section {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        
        .section-title {
            font-size: 22px;
            font-weight: bold;
            color: #1A7BB7;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-content {
            font-size: 16px;
            color: #607D8B;
            line-height: 1.6;
        }
        
        .findings-list {
            list-style-type: none;
        }
        
        .findings-list li {
            margin-bottom: 10px;
            padding-left: 25px;
            position: relative;
        }
        
        .findings-list li::before {
            content: '\f058';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            left: 0;
            color: #4CAF78;
        }
        
        .critical-finding {
            color: #E57373;
            font-weight: bold;
        }
        
        .critical-finding::before {
            content: '\f071';
            color: #E57373;
        }
        
        .chart-container {
            height: 200px;
            margin-top: 10px;
        }
        
        .background-decoration {
            position: absolute;
            bottom: -100px;
            right: -100px;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(76, 175, 120, 0.1) 0%, rgba(249, 251, 252, 0) 70%);
            border-radius: 50%;
            z-index: -1;
        }
        
        .dna-decoration {
            position: absolute;
            bottom: 20px;
            left: 20px;
            opacity: 0.1;
            font-size: 60px;
            color: #1A7BB7;
            z-index: -1;
        }
        
        .heartbeat-line {
            position: absolute;
            bottom: 10px;
            right: 20px;
            height: 30px;
            width: 150px;
            z-index: 2;
        }
    </style>
</head>
<body>
    <div class="slide-container">
        <!-- Header -->
        <div class="header">
            <div class="header-title">大气光学现象分析</div>
            <div class="header-decoration">
                <i class="fas fa-sun fa-2x"></i>
            </div>
        </div>
        
        <!-- Content -->
        <div class="content">
            <!-- Left: Image Display -->
            <div class="image-container">
                <div class="image-display">
                    <img src="http://hyperphysics.phy-astr.gsu.edu/hbase/atmos/imgatm/blusky.png" alt="暖色天空现象" class="medical-image">
                    <div class="image-overlay">太阳低角度时天空色彩变化</div>
                    <div class="image-markers">
                        <i class="fas fa-crosshairs marker" style="top: 30%; left: 40%;"></i>
                        <i class="fas fa-crosshairs marker" style="top: 70%; left: 60%;"></i>
                    </div>
                </div>
            </div>
            
            <!-- Right: Information -->
            <div class="info-container">
                <div class="info-section">
                    <div class="section-title">
                        <i class="fas fa-clipboard-list"></i>
                        现象信息
                    </div>
                    <div class="section-content">
                        <p><strong>现象名称：</strong>暖色天空现象</p>
                        <p><strong>观测时间：</strong>日出/日落时分</p>
                        <p><strong>观测地点：</strong>全球各地</p>
                        <p><strong>现象原因：</strong>太阳低角度时，蓝光被散射殆尽，剩余红光形成暖色天空</p>
                    </div>
                </div>
                
                <div class="info-section">
                    <div class="section-title">
                        <i class="fas fa-search-plus"></i>
                        光学分析
                    </div>
                    <div class="section-content">
                        <ul class="findings-list">
                            <li>太阳处于低角度时，光线穿过大气层的路径更长</li>
                            <li>短波长的蓝光被大气分子散射殆尽</li>
                            <li class="critical-finding">剩余长波长的红光主导天空色彩</li>
                            <li>大气中颗粒物会增强红色效果</li>
                            <li>云层可以反射和散射红光，形成壮观景象</li>
                        </ul>
                    </div>
                </div>
                
                <div class="info-section">
                    <div class="section-title">
                        <i class="fas fa-chart-line"></i>
                        波长分析
                    </div>
                    <div class="section-content">
                        <p>不同波长光线在大气中的散射程度</p>
                        <div id="densityChart" class="chart-container"></div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Background Decorations -->
        <div class="background-decoration"></div>
        <i class="fas fa-atom dna-decoration"></i>
        
        <svg class="heartbeat-line" viewBox="0 0 200 30" xmlns="http://www.w3.org/2000/svg">
            <path d="M0,15 L20,15 L30,5 L40,25 L50,5 L60,15 L80,15 L90,10 L100,20 L110,10 L120,15 L140,15 L150,5 L160,25 L170,15 L200,15" 
                  stroke="#1A7BB7" 
                  stroke-width="2" 
                  fill="none" />
        </svg>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 初始化密度分析图表
            const densityChart = echarts.init(document.getElementById('densityChart'));
            
            const option = {
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '10%',
                    top: '10%',
                    containLabel: true
                },
                xAxis: {
                    type: 'category',
                    data: ['紫光', '蓝光', '绿光', '黄光', '红光'],
                    axisLabel: {
                        color: '#607D8B'
                    }
                },
                yAxis: {
                    type: 'value',
                    name: '散射强度',
                    axisLabel: {
                        color: '#607D8B'
                    }
                },
                series: [
                    {
                        data: [100, 80, 60, 40, 20],
                        type: 'bar',
                        itemStyle: {
                            color: function(params) {
                                const colorList = ['#8A2BE2', '#1A7BB7', '#4CAF78', '#FFD700', '#E57373'];
                                return colorList[params.dataIndex];
                            }
                        }
                    },
                    {
                        data: [90, 70, 50, 30, 10],
                        type: 'line',
                        smooth: true,
                        symbol: 'circle',
                        symbolSize: 8,
                        lineStyle: {
                            color: '#1A7BB7',
                            width: 2
                        },
                        itemStyle: {
                            color: '#1A7BB7'
                        }
                    }
                ],
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                }
            };
            
            densityChart.setOption(option);
            
            // 响应窗口大小变化
            window.addEventListener('resize', function() {
                densityChart.resize();
            });
        });
    </script>
</body>
</html>

第12页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>其他影响因素</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "思源黑体", sans-serif;
        }
        
        .slide-container {
            width: 100%;
            height: 100vh;
            display: flex;
            background-color: #F9FBFC;
            position: relative;
        }
        
        .left-bar {
            width: 120px;
            height: 100%;
            background-color: #1A7BB7;
            position: relative;
            overflow: hidden;
        }
        
        .left-bar::before {
            content: "";
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background-color: rgba(76, 175, 120, 0.2);
            top: -100px;
            left: -150px;
        }
        
        .left-bar::after {
            content: "";
            position: absolute;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background-color: rgba(76, 175, 120, 0.15);
            bottom: -50px;
            left: -100px;
        }
        
        .content {
            flex: 1;
            padding: 60px 80px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .chapter-title {
            font-size: 48px;
            font-weight: bold;
            color: #1A7BB7;
            margin-bottom: 30px;
        }
        
        .chapter-description {
            font-size: 24px;
            color: #607D8B;
            max-width: 700px;
            line-height: 1.6;
        }
        
        .medical-icon {
            position: absolute;
            right: 60px;
            bottom: 60px;
            font-size: 150px;
            color: rgba(26, 123, 183, 0.1);
        }
        
        .dna-decoration {
            position: absolute;
            top: 40px;
            right: 40px;
            width: 220px;
            height: 100px;
        }
        
        .heartbeat-line {
            position: absolute;
            bottom: 30px;
            left: 150px;
            width: 350px;
            height: 50px;
            opacity: 0.2;
        }
    </style>
</head>
<body>
    <div class="slide-container">
        <div class="left-bar"></div>
        <div class="content">
            <h1 class="chapter-title">其他影响因素</h1>
            <p class="chapter-description">
                本章节将探讨除主要因素外的其他潜在影响因素，包括环境、生活方式、遗传背景等，
                帮助全面理解疾病发展过程和治疗效果的多样性。
            </p>
        </div>
        
        <div class="medical-icon">
            <i class="fas fa-clipboard-list"></i>
        </div>
        
        <svg class="dna-decoration" viewBox="0 0 100 40" xmlns="http://www.w3.org/2000/svg">
            <path d="M10,20 Q25,5 40,20 T70,20 T100,20" stroke="#1A7BB7" stroke-width="1" fill="none" opacity="0.3"/>
            <path d="M10,20 Q25,35 40,20 T70,20 T100,20" stroke="#1A7BB7" stroke-width="1" fill="none" opacity="0.3"/>
            <circle cx="10" cy="20" r="2" fill="#4CAF78" opacity="0.5"/>
            <circle cx="40" cy="20" r="2" fill="#4CAF78" opacity="0.5"/>
            <circle cx="70" cy="20" r="2" fill="#4CAF78" opacity="0.5"/>
            <circle cx="100" cy="20" r="2" fill="#4CAF78" opacity="0.5"/>
            <circle cx="25" cy="12.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="25" cy="27.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="55" cy="12.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="55" cy="27.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="85" cy="12.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="85" cy="27.5" r="1.5" fill="#E57373" opacity="0.5"/>
        </svg>
        
        <svg class="heartbeat-line" viewBox="0 0 100 20" xmlns="http://www.w3.org/2000/svg">
            <path d="M0,10 L10,10 L15,3 L25,17 L35,3 L45,17 L50,10 L60,10 L65,5 L70,15 L75,5 L85,10 L100,10" 
                  stroke="#1A7BB7" 
                  stroke-width="1.5" 
                  fill="none"/>
        </svg>
    </div>
</body>
</html>

第13页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>大气光学现象分析 - 文本内容版式</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body, html {
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "思源黑体", sans-serif;
            background-color: #F5F9FC;
        }
        
        .slide-container {
            width: 100%;
            height: 100%;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        
        .header {
            height: 60px;
            background: linear-gradient(90deg, #0A5D94 0%, #3A9C6C 100%);
            position: relative;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            z-index: 10;
        }
        
        .header::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><path d="M0,50 Q25,25 50,50 T100,50" fill="none" stroke="rgba(255,255,255,0.15)" stroke-width="2" /></svg>');
            background-size: 100px 100px;
            opacity: 0.5;
        }
        
        .header-content {
            padding: 0 40px;
            height: 100%;
            color: white;
            position: relative;
            z-index: 2;
            font-size: 18px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .header-icon {
            margin-right: 15px;
            font-size: 22px;
            color: rgba(255,255,255,0.9);
        }
        
        .content {
            flex: 1;
            position: relative;
            background-color: #F5F9FC;
            display: flex;
            flex-direction: column;
            padding: 15px 30px 20px;
        }
        
        .title-section {
            margin-bottom: 15px;
            position: relative;
        }
        
        .title {
            font-size: 36px;
            font-weight: bold;
            color: #0A5D94;
            margin-bottom: 8px;
            position: relative;
            display: inline-block;
        }
        
        .title::after {
            content: "";
            position: absolute;
            bottom: -6px;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #0A5D94 0%, #3A9C6C 100%);
            border-radius: 2px;
        }
        
        .subtitle {
            font-size: 24px;
            color: #607D8B;
            font-weight: 500;
        }
        
        .content-wrapper {
            display: flex;
            justify-content: center; /* 水平居中 */
            align-items: center; /* 垂直居中 */
            gap: 20px;
            flex: 1;
        }
        
        .content-column {
            flex: 0 1 auto; /* 不强制拉伸，根据内容自适应宽度 */
            max-width: 45%; /* 限制最大宽度 */
            display: flex;
            flex-direction: column;
            justify-content: center; /* 垂直居中 */
        }
        
        .text-card {
            background-color: white;
            border-radius: 12px;
            padding: 16px 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
            height: auto; /* 高度自适应内容 */
            display: flex;
            flex-direction: column;
            justify-content: center; /* 内容垂直居中 */
        }
        
        .card-accent {
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
        }
        
        .accent-blue {
            background: linear-gradient(180deg, #0A5D94 0%, #3A9C6C 100%);
        }
        
        .accent-green {
            background: linear-gradient(180deg, #3A9C6C 0%, #0A5D94 100%);
        }
        
        .section-title {
            font-size: 24px;
            font-weight: bold;
            color: #0A5D94;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
        }
        
        .section-icon {
            margin-right: 10px;
            width: 30px;
            height: 30px;
            background-color: rgba(10, 93, 148, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #0A5D94;
            font-size: 15px;
        }
        
        .section-subtitle {
            font-size: 20px;
            font-weight: 600;
            color: #3A9C6C;
            margin-bottom: 8px;
            margin-top: 10px;
            padding-left: 40px;
        }
        
        .text-content {
            font-size: 18px;
            line-height: 1.5;
            color: #444;
        }
        
        .text-content p {
            margin-bottom: 8px;
        }
        
        ul.bullet-list {
            list-style: none;
            padding-left: 5px;
            margin-top: 8px;
        }
        
        ul.bullet-list li {
            position: relative;
            margin-bottom: 6px;
            padding-left: 24px;
            font-size: 18px;
        }
        
        ul.bullet-list li::before {
            content: "";
            position: absolute;
            left: 0;
            top: 9px;
            width: 9px;
            height: 9px;
            border-radius: 50%;
            background-color: #0A5D94;
        }
        
        ul.bullet-list li ul.sub-bullet-list {
            list-style: none;
            padding-left: 5px;
            margin-top: 5px;
        }
        
        ul.bullet-list li ul.sub-bullet-list li {
            padding-left: 22px;
            margin-bottom: 5px;
            font-size: 17px;
        }
        
        ul.bullet-list li ul.sub-bullet-list li::before {
            background-color: #3A9C6C;
            width: 7px;
            height: 7px;
            top: 9px;
        }
        
        .highlight {
            color: #E57373;
            font-weight: bold;
        }
        
        .decoration-circle {
            position: absolute;
            border-radius: 50%;
            z-index: 0;
            opacity: 0.4;
        }
        
        .circle-1 {
            bottom: -100px;
            right: -50px;
            width: 200px;
            height: 200px;
            background: radial-gradient(circle, rgba(58,156,108,0.1) 0%, rgba(10,93,148,0.05) 100%);
        }
        
        .circle-2 {
            top: 20%;
            left: -80px;
            width: 150px;
            height: 150px;
            background: radial-gradient(circle, rgba(10,93,148,0.1) 0%, rgba(58,156,108,0.05) 100%);
        }
        
        .circle-3 {
            top: 40%;
            right: 30%;
            width: 80px;
            height: 80px;
            background: radial-gradient(circle, rgba(58,156,108,0.08) 0%, rgba(10,93,148,0.04) 100%);
        }
    </style>
</head>
<body>
    <div class="slide-container">
        <!-- 顶部装饰条 -->
        <div class="header">
            <div class="header-content">
                <div>
                    <i class="fas fa-cloud header-icon"></i>
                    <span>大气光学研究中心</span>
                </div>
                <!-- 页码已移除 -->
            </div>
        </div>
        
        <!-- 内容区域 -->
        <div class="content">
            <div class="title-section">
                <h1 class="title">大气光学现象分析</h1>
                <h2 class="subtitle">影响天空颜色的关键因素</h2>
            </div>
            
            <div class="content-wrapper">
                <div class="content-column">
                    <div class="text-card">
                        <div class="card-accent accent-blue"></div>
                        <h3 class="section-title">
                            <div class="section-icon"><i class="fas fa-smog"></i></div>
                            大气浑浊度的影响
                        </h3>
                        
                        <div class="text-content">
                            <p>大气浑浊度是影响天空颜色的重要因素之一，特别是在污染或沙尘天气条件下，米氏散射效应会显著改变天空的视觉表现。</p>
                            
                            <ul class="bullet-list">
                                <li>污染或沙尘天气中，米氏散射占主导地位</li>
                                <li>米氏散射无显著波长选择性
                                    <ul class="sub-bullet-list">
                                        <li>导致所有波长的光被均匀散射</li>
                                        <li>使天空呈现灰白色而非蓝色</li>
                                    </ul>
                                </li>
                                <li>气溶胶浓度增加会增强散射效应</li>
                                <li>城市地区常见灰白色天空现象</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="content-column">
                    <div class="text-card">
                        <div class="card-accent accent-green"></div>
                        <h3 class="section-title">
                            <div class="section-icon"><i class="fas fa-mountain"></i></div>
                            海拔与湿度的影响
                        </h3>
                        
                        <h4 class="section-subtitle">大气条件对天空颜色的改变</h4>
                        
                        <div class="text-content">
                            <p>海拔高度和大气湿度是影响天空颜色的另外两个重要因素，它们通过改变大气密度和散射特性来影响我们看到的天空颜色。</p>
                            
                            <ul class="bullet-list">
                                <li>高海拔地区空气稀薄，散射减弱
                                    <span class="highlight">天空颜色更深更蓝</span>
                                </li>
                                <li>湿润空气中水分子增加散射效应</li>
                                <li>水分子可能略微改变光谱分布
                                    <ul class="sub-bullet-list">
                                        <li>导致天空颜色轻微偏白</li>
                                        <li>影响日出日落时的色彩表现</li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 装饰圆形 -->
            <div class="decoration-circle circle-1"></div>
            <div class="decoration-circle circle-2"></div>
            <div class="decoration-circle circle-3"></div>
        </div>
    </div>
</body>
</html>

第14页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>医疗PPT总结页</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "思源黑体", sans-serif;
        }
        
        .slide-container {
            width: 100%;
            height: 100vh;
            display: flex;
            background-color: #F9FBFC;
            position: relative;
        }
        
        .left-bar {
            width: 120px;
            height: 100%;
            background-color: #1A7BB7;
            position: relative;
            overflow: hidden;
        }
        
        .left-bar::before {
            content: "";
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background-color: rgba(76, 175, 120, 0.2);
            top: -100px;
            left: -150px;
        }
        
        .left-bar::after {
            content: "";
            position: absolute;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background-color: rgba(76, 175, 120, 0.15);
            bottom: -50px;
            left: -100px;
        }
        
        .content {
            flex: 1;
            padding: 60px 80px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .chapter-title {
            font-size: 48px;
            font-weight: bold;
            color: #1A7BB7;
            margin-bottom: 30px;
        }
        
        .chapter-description {
            font-size: 24px;
            color: #607D8B;
            max-width: 700px;
            line-height: 1.6;
        }
        
        .medical-icon {
            position: absolute;
            right: 60px;
            bottom: 60px;
            font-size: 150px;
            color: rgba(26, 123, 183, 0.1);
        }
        
        .dna-decoration {
            position: absolute;
            top: 40px;
            right: 40px;
            width: 220px;
            height: 100px;
        }
        
        .heartbeat-line {
            position: absolute;
            bottom: 30px;
            left: 150px;
            width: 350px;
            height: 50px;
            opacity: 0.2;
        }
    </style>
</head>
<body>
    <div class="slide-container">
        <div class="left-bar"></div>
        <div class="content">
            <h1 class="chapter-title">总结</h1>
        </div>
        
        <div class="medical-icon">
            <i class="fas fa-stethoscope"></i>
        </div>
        
        <svg class="dna-decoration" viewBox="0 0 100 40" xmlns="http://www.w3.org/2000/svg">
            <path d="M10,20 Q25,5 40,20 T70,20 T100,20" stroke="#1A7BB7" stroke-width="1" fill="none" opacity="0.3"/>
            <path d="M10,20 Q25,35 40,20 T70,20 T100,20" stroke="#1A7BB7" stroke-width="1" fill="none" opacity="0.3"/>
            <circle cx="10" cy="20" r="2" fill="#4CAF78" opacity="0.5"/>
            <circle cx="40" cy="20" r="2" fill="#4CAF78" opacity="0.5"/>
            <circle cx="70" cy="20" r="2" fill="#4CAF78" opacity="0.5"/>
            <circle cx="100" cy="20" r="2" fill="#4CAF78" opacity="0.5"/>
            <circle cx="25" cy="12.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="25" cy="27.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="55" cy="12.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="55" cy="27.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="85" cy="12.5" r="1.5" fill="#E57373" opacity="0.5"/>
            <circle cx="85" cy="27.5" r="1.5" fill="#E57373" opacity="0.5"/>
        </svg>
        
        <svg class="heartbeat-line" viewBox="0 0 100 20" xmlns="http://www.w3.org/2000/svg">
            <path d="M0,10 L10,10 L15,3 L25,17 L35,3 L45,17 L50,10 L60,10 L65,5 L70,15 L75,5 L85,10 L100,10" 
                  stroke="#1A7BB7" 
                  stroke-width="1.5" 
                  fill="none"/>
        </svg>
    </div>
</body>
</html>

第15页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>科学PPT模板 - 天空颜色现象解析</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body, html {
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "思源黑体", sans-serif;
            background-color: #F5F9FC;
        }
        
        .slide-container {
            width: 100%;
            height: 100%;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        
        .header {
            height: 60px;
            background: linear-gradient(90deg, #0A5D94 0%, #3A9C6C 100%);
            position: relative;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            z-index: 10;
        }
        
        .header::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><path d="M0,50 Q25,25 50,50 T100,50" fill="none" stroke="rgba(255,255,255,0.15)" stroke-width="2" /></svg>');
            background-size: 100px 100px;
            opacity: 0.5;
        }
        
        .header-content {
            padding: 0 40px;
            height: 100%;
            color: white;
            position: relative;
            z-index: 2;
            font-size: 18px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .header-icon {
            margin-right: 15px;
            font-size: 22px;
            color: rgba(255,255,255,0.9);
        }
        
        .content {
            flex: 1;
            position: relative;
            background-color: #F5F9FC;
            display: flex;
            flex-direction: column;
            padding: 15px 30px 20px;
        }
        
        .title-section {
            margin-bottom: 15px;
            position: relative;
        }
        
        .title {
            font-size: 36px;
            font-weight: bold;
            color: #0A5D94;
            margin-bottom: 8px;
            position: relative;
            display: inline-block;
        }
        
        .title::after {
            content: "";
            position: absolute;
            bottom: -6px;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #0A5D94 0%, #3A9C6C 100%);
            border-radius: 2px;
        }
        
        .subtitle {
            font-size: 24px;
            color: #607D8B;
            font-weight: 500;
        }
        
        .content-wrapper {
            display: flex;
            justify-content: center; /* 水平居中 */
            align-items: center; /* 垂直居中 */
            gap: 20px;
            flex: 1;
        }
        
        .content-column {
            flex: 0 1 auto; /* 不强制拉伸，根据内容自适应宽度 */
            max-width: 45%; /* 限制最大宽度 */
            display: flex;
            flex-direction: column;
            justify-content: center; /* 垂直居中 */
        }
        
        .text-card {
            background-color: white;
            border-radius: 12px;
            padding: 16px 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
            height: auto; /* 高度自适应内容 */
            display: flex;
            flex-direction: column;
            justify-content: center; /* 内容垂直居中 */
        }
        
        .card-accent {
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
        }
        
        .accent-blue {
            background: linear-gradient(180deg, #0A5D94 0%, #3A9C6C 100%);
        }
        
        .accent-green {
            background: linear-gradient(180deg, #3A9C6C 0%, #0A5D94 100%);
        }
        
        .section-title {
            font-size: 24px;
            font-weight: bold;
            color: #0A5D94;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
        }
        
        .section-icon {
            margin-right: 10px;
            width: 30px;
            height: 30px;
            background-color: rgba(10, 93, 148, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #0A5D94;
            font-size: 15px;
        }
        
        .section-subtitle {
            font-size: 20px;
            font-weight: 600;
            color: #3A9C6C;
            margin-bottom: 8px;
            margin-top: 10px;
            padding-left: 40px;
        }
        
        .text-content {
            font-size: 18px;
            line-height: 1.5;
            color: #444;
        }
        
        .text-content p {
            margin-bottom: 8px;
        }
        
        ul.bullet-list {
            list-style: none;
            padding-left: 5px;
            margin-top: 8px;
        }
        
        ul.bullet-list li {
            position: relative;
            margin-bottom: 6px;
            padding-left: 24px;
            font-size: 18px;
        }
        
        ul.bullet-list li::before {
            content: "";
            position: absolute;
            left: 0;
            top: 9px;
            width: 9px;
            height: 9px;
            border-radius: 50%;
            background-color: #0A5D94;
        }
        
        ul.bullet-list li ul.sub-bullet-list {
            list-style: none;
            padding-left: 5px;
            margin-top: 5px;
        }
        
        ul.bullet-list li ul.sub-bullet-list li {
            padding-left: 22px;
            margin-bottom: 5px;
            font-size: 17px;
        }
        
        ul.bullet-list li ul.sub-bullet-list li::before {
            background-color: #3A9C6C;
            width: 7px;
            height: 7px;
            top: 9px;
        }
        
        .highlight {
            color: #E57373;
            font-weight: bold;
        }
        
        .decoration-circle {
            position: absolute;
            border-radius: 50%;
            z-index: 0;
            opacity: 0.4;
        }
        
        .circle-1 {
            bottom: -100px;
            right: -50px;
            width: 200px;
            height: 200px;
            background: radial-gradient(circle, rgba(58,156,108,0.1) 0%, rgba(10,93,148,0.05) 100%);
        }
        
        .circle-2 {
            top: 20%;
            left: -80px;
            width: 150px;
            height: 150px;
            background: radial-gradient(circle, rgba(10,93,148,0.1) 0%, rgba(58,156,108,0.05) 100%);
        }
        
        .circle-3 {
            top: 40%;
            right: 30%;
            width: 80px;
            height: 80px;
            background: radial-gradient(circle, rgba(58,156,108,0.08) 0%, rgba(10,93,148,0.04) 100%);
        }
    </style>
</head>
<body>
    <div class="slide-container">
        <!-- 顶部装饰条 -->
        <div class="header">
            <div class="header-content">
                <div>
                    <i class="fas fa-cloud header-icon"></i>
                    <span>大气光学现象研究</span>
                </div>
                <!-- 页码已移除 -->
            </div>
        </div>
        
        <!-- 内容区域 -->
        <div class="content">
            <div class="title-section">
                <h1 class="title">天空颜色的科学解析</h1>
                <h2 class="subtitle">从瑞利散射到大气光学</h2>
            </div>
            
            <div class="content-wrapper">
                <div class="content-column">
                    <div class="text-card">
                        <div class="card-accent accent-blue"></div>
                        <h3 class="section-title">
                            <div class="section-icon"><i class="fas fa-sun"></i></div>
                            蓝天现象的本质
                        </h3>
                        
                        <div class="text-content">
                            <p>天空呈现蓝色的根本原因是瑞利散射效应，这一物理现象揭示了短波光线与大气分子相互作用的规律。</p>
                            
                            <ul class="bullet-list">
                                <li>瑞利散射强度与波长的四次方成反比
                                    <ul class="sub-bullet-list">
                                        <li>蓝光波长(450nm)比红光(650nm)短约30%</li>
                                        <li>蓝光散射强度是红光的约4.5倍</li>
                                    </ul>
                                </li>
                                <li>大气分子(N₂、O₂)直径远小于可见光波长</li>
                                <li>散射光呈各向同性分布</li>
                                <li>人眼对蓝光敏感度较高</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="content-column">
                    <div class="text-card">
                        <div class="card-accent accent-green"></div>
                        <h3 class="section-title">
                            <div class="section-icon"><i class="fas fa-sunrise"></i></div>
                            其他天空颜色现象
                        </h3>
                        
                        <h4 class="section-subtitle">光路长度与散射机制</h4>
                        
                        <div class="text-content">
                            <p>日出日落时的红色和污染时的灰白色天空，是光路长度变化、米氏散射等多种因素共同作用的结果。</p>
                            
                            <ul class="bullet-list">
                                <li>日出日落时太阳光穿过<span class="highlight">更厚的大气层</span>
                                    <ul class="sub-bullet-list">
                                        <li>蓝光被大量散射掉</li>
                                        <li>红光直接穿透到达观察者</li>
                                    </ul>
                                </li>
                                <li>空气污染时米氏散射主导
                                    <ul class="sub-bullet-list">
                                        <li>气溶胶粒子尺寸接近或大于光波长</li>
                                        <li>散射光强与波长关系减弱</li>
                                    </ul>
                                </li>
                                <li>云层反射导致灰白色天空</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 装饰圆形 -->
            <div class="decoration-circle circle-1"></div>
            <div class="decoration-circle circle-2"></div>
            <div class="decoration-circle circle-3"></div>
        </div>
    </div>
</body>
</html>

第16页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rayleigh散射参考文献页</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@400;500;700&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body, html {
            height: 100%;
            width: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "Noto Sans SC", sans-serif;
            background-color: #F9FBFC;
            font-size: 18px;
        }
        
        .slide-container {
            width: 100vw;
            height: 100vh;
            display: flex;
            flex-direction: column;
            position: relative;
            overflow: hidden;
        }
        
        .slide-header {
            background-color: #1A7BB7;
            color: white;
            padding: 1.8rem 2.2rem;
            position: relative;
            z-index: 10;
        }
        
        .slide-header h1 {
            font-size: 38px;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        
        .slide-header h2 {
            font-size: 28px;
            font-weight: normal;
            opacity: 0.9;
        }
        
        .slide-content {
            flex: 1;
            padding: 2.5rem;
            position: relative;
            overflow-y: auto;
            background-color: #F9FBFC;
        }
        
        .reference-list {
            list-style-type: none;
            counter-reset: reference-counter;
        }
        
        .reference-item {
            margin-bottom: 1.5rem;
            padding-left: 2.5rem;
            position: relative;
            font-size: 19px;
            line-height: 1.7;
            color: #333;
            border-left: 3px solid #1A7BB7;
            padding-left: 1.8rem;
            margin-left: 1.2rem;
        }
        
        .reference-item::before {
            counter-increment: reference-counter;
            content: "[" counter(reference-counter) "]";
            position: absolute;
            left: -1.5rem;
            top: 0;
            color: #1A7BB7;
            font-weight: bold;
            width: 2rem;
            text-align: center;
            background-color: #F9FBFC;
            font-size: 20px;
        }
        
        .reference-item:hover {
            background-color: rgba(26, 123, 183, 0.05);
            transition: background-color 0.3s ease;
        }
        
        .reference-item .author {
            font-weight: 500;
        }
        
        .reference-item .title {
            font-style: italic;
        }
        
        .reference-item .journal {
            font-weight: 500;
        }
        
        .reference-item .doi {
            color: #4CAF78;
            text-decoration: none;
        }
        
        .reference-item .doi:hover {
            text-decoration: underline;
        }
        
        .decoration {
            position: absolute;
            z-index: 1;
        }
        
        .dna-helix {
            top: 10%;
            right: 2%;
            opacity: 0.1;
            width: 150px;
            height: 300px;
        }
        
        .heartbeat-line {
            bottom: 5%;
            left: 0;
            right: 0;
            height: 50px;
            opacity: 0.1;
        }
        
        .medical-cross {
            top: 20%;
            left: 3%;
            width: 80px;
            height: 80px;
            opacity: 0.1;
        }
        
        .section-title {
            font-size: 26px;
            color: #1A7BB7;
            margin-bottom: 1.8rem;
            padding-bottom: 0.6rem;
            border-bottom: 2px solid #4CAF78;
            display: flex;
            align-items: center;
        }
        
        .section-title i {
            margin-right: 0.75rem;
            font-size: 24px;
        }
        
        .grid-background {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: linear-gradient(rgba(96, 125, 139, 0.05) 1px, transparent 1px),
                              linear-gradient(90deg, rgba(96, 125, 139, 0.05) 1px, transparent 1px);
            background-size: 20px 20px;
            z-index: 0;
        }
        
        .sky-decoration {
            position: absolute;
            top: 15%;
            right: 5%;
            width: 120px;
            height: 120px;
            opacity: 0.1;
        }
    </style>
</head>
<body>
    <div class="slide-container">
        <!-- 装饰元素 -->
        <div class="decoration dna-helix">
            <svg viewBox="0 0 100 200" xmlns="http://www.w3.org/2000/svg">
                <path d="M50,0 Q70,50 50,100 Q30,150 50,200" stroke="#1A7BB7" stroke-width="2" fill="none" />
                <path d="M50,0 Q30,50 50,100 Q70,150 50,200" stroke="#1A7BB7" stroke-width="2" fill="none" />
                <line x1="50" y1="25" x2="70" y2="25" stroke="#4CAF78" stroke-width="2" />
                <line x1="50" y1="50" x2="30" y2="50" stroke="#4CAF78" stroke-width="2" />
                <line x1="50" y1="75" x2="70" y2="75" stroke="#4CAF78" stroke-width="2" />
                <line x1="50" y1="100" x2="30" y2="100" stroke="#4CAF78" stroke-width="2" />
                <line x1="50" y1="125" x2="70" y2="125" stroke="#4CAF78" stroke-width="2" />
                <line x1="50" y1="150" x2="30" y2="150" stroke="#4CAF78" stroke-width="2" />
                <line x1="50" y1="175" x2="70" y2="175" stroke="#4CAF78" stroke-width="2" />
            </svg>
        </div>
        
        <div class="decoration heartbeat-line">
            <svg viewBox="0 0 800 100" xmlns="http://www.w3.org/2000/svg">
                <path d="M0,50 L100,50 L150,20 L200,80 L250,30 L300,70 L350,40 L400,60 L450,50 L500,50 L550,20 L600,80 L650,30 L700,70 L750,40 L800,60" 
                      stroke="#E57373" stroke-width="2" fill="none" />
            </svg>
        </div>
        
        <div class="decoration medical-cross">
            <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                <rect x="40" y="20" width="20" height="60" fill="#1A7BB7" />
                <rect x="20" y="40" width="60" height="20" fill="#1A7BB7" />
            </svg>
        </div>
        
        <div class="decoration sky-decoration">
            <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                <circle cx="50" cy="50" r="40" fill="#87CEEB" />
                <circle cx="30" cy="40" r="5" fill="white" opacity="0.8" />
                <circle cx="60" cy="30" r="7" fill="white" opacity="0.8" />
                <circle cx="70" cy="60" r="6" fill="white" opacity="0.8" />
            </svg>
        </div>
        
        <div class="grid-background"></div>
        
        <!-- 幻灯片头部 -->
        <div class="slide-header">
            <h1>参考文献</h1>
            <h2>Rayleigh散射与天空颜色研究</h2>
        </div>
        
        <!-- 幻灯片内容 -->
        <div class="slide-content">
            <h2 class="section-title">
                <i class="fas fa-cloud-sun"></i>文献列表
            </h2>
            
            <ul class="reference-list">
                <li class="reference-item">
                    <span class="author">iTRUST EHR Team</span> 
                    <span class="title">Why is the sky blue? What is Rayleigh scattering?</span> 
                    <span class="journal">iTRUST EHR Blog.</span> 
                    <a href="https://www.itrust.io/blog/why-is-the-sky-blue-what-is-rayleigh-scattering/" class="doi">原文链接</a>
                </li>
                
                <li class="reference-item">
                    <span class="author">Reddit Community</span> 
                    <span class="title">ELI5: HOW does Rayleigh scattering make the sky red/blue/whatever?</span> 
                    <span class="journal">Reddit Explain Like I'm Five.</span> 
                    <a href="https://www.reddit.com/r/explainlikeimfive/comments/lyhooz/eli5how_does_rayleigh_scattering_make_the_sky/" class="doi">原文链接</a>
                </li>
                
                <li class="reference-item">
                    <span class="author">HyperPhysics Team</span> 
                    <span class="title">Blue Sky and Rayleigh Scattering.</span> 
                    <span class="journal">HyperPhysics.</span> 
                    <a href="http://hyperphysics.phy-astr.gsu.edu/hbase/atmos/blusky.html" class="doi">原文链接</a>
                </li>
            </ul>
        </div>
    </div>
</body>
</html>

第17页
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>医疗演示文稿 - 联系我们</title>
    <link href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-100-M/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://s2.ssl.qhres2.com/static/56662140ef7d5d03.css" rel="stylesheet">
    <style>
        @font-face {
            font-family: 'Source Han Sans CN';
            src: local('Source Han Sans CN'), local('思源黑体');
            font-weight: normal;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body, html {
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-family: "Microsoft YaHei", "Source Han Sans CN", sans-serif;
            background-color: #F9FBFC;
            color: #333;
        }
        
        .slide-container {
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            position: relative;
            background: linear-gradient(135deg, #F9FBFC 0%, #E8F1F8 100%);
        }
        
        .slide-header {
            height: 8px;
            background: linear-gradient(90deg, #1A7BB7 0%, #4CAF78 100%);
        }
        
        .slide-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            padding: 2rem 4rem;
            position: relative;
            z-index: 2;
        }
        
        .thank-you {
            text-align: center;
            margin-top: 6rem; /* 显著增加顶部边距，让标题往下移更多 */
            margin-bottom: 3rem;
        }
        
        .thank-you h1 {
            font-size: 48px;
            font-weight: bold;
            color: #1A7BB7;
            margin-bottom: 1.5rem;
        }
        
        .thank-you p {
            font-size: 26px;
            color: #607D8B;
            max-width: 800px;
            margin: 0 auto;
        }
        
        .contact-container {
            display: flex;
            justify-content: center; /* 水平居中 */
            align-items: center;
            margin: 2rem auto; /* 上下边距，左右自动居中 */
            max-width: 1000px; /* 设置最大宽度 */
            width: 90%; /* 设置宽度百分比 */
        }
        
        .contact-info {
            flex: 1;
            padding: 2rem;
        }
        
        .contact-info h2 {
            font-size: 32px;
            color: #1A7BB7;
            margin-bottom: 1.8rem;
            font-weight: bold;
        }
        
        .info-item {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        
        .info-item i {
            color: #4CAF78;
            font-size: 28px;
            width: 40px;
            text-align: center;
            margin-right: 1.5rem;
        }
        
        .info-item span {
            font-size: 24px;
            color: #607D8B;
        }
        
        .qr-code {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 2rem;
        }
        
        .qr-code-box {
            width: 200px;
            height: 200px;
            background-color: white;
            border: 1px solid #ddd;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        
        .qr-code p {
            font-size: 20px;
            color: #607D8B;
            text-align: center;
        }
        
        .logo {
            position: absolute;
            bottom: 2rem;
            left: 4rem;
            display: flex;
            align-items: center;
        }
        
        .logo-icon {
            width: 60px;
            height: 60px;
            background-color: #1A7BB7;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1.2rem;
            color: white;
            font-size: 30px;
        }
        
        .logo-text {
            font-size: 26px;
            font-weight: bold;
            color: #1A7BB7;
        }
        
        .background-elements {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
            pointer-events: none;
            opacity: 0.1;
        }
        
        .dna-helix {
            position: absolute;
            top: 10%;
            right: 5%;
            width: 200px;
            height: 400px;
            border-right: 3px dashed #1A7BB7;
            transform: rotate(30deg);
        }
        
        .heartbeat-line {
            position: absolute;
            bottom: 15%;
            left: 0;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg, transparent 0%, #E57373 50%, transparent 100%);
        }
        
        .circle-element {
            position: absolute;
            border-radius: 50%;
        }
        
        .circle-1 {
            width: 300px;
            height: 300px;
            border: 2px solid #4CAF78;
            opacity: 0.1;
            top: -150px;
            left: -150px;
        }
        
        .circle-2 {
            width: 200px;
            height: 200px;
            border: 2px solid #1A7BB7;
            opacity: 0.1;
            bottom: -100px;
            right: -100px;
        }
        
        .medical-cross {
            position: absolute;
            width: 100px;
            height: 100px;
            bottom: 10%;
            right: 10%;
            opacity: 0.1;
        }
        
        .medical-cross::before,
        .medical-cross::after {
            content: "";
            position: absolute;
            background-color: #E57373;
        }
        
        .medical-cross::before {
            width: 100%;
            height: 20px;
            top: 40px;
        }
        
        .medical-cross::after {
            height: 100%;
            width: 20px;
            left: 40px;
        }
        
        /* QR Code Generator */
        .qr-code-img {
            width: 180px;
            height: 180px;
        }
    </style>
</head>
<body>
    <div class="slide-container">
        <div class="slide-header"></div>
        
        <div class="slide-content">
            <div class="thank-you">
                <h1>感谢观看！</h1>
                <p>如有疑问，请联系[联系方式]</p>
            </div>
            
            <div class="contact-container">
                <div class="contact-info">
                    <h2>联系我们</h2>
                    <div class="info-item">
                        <i class="fas fa-phone-alt"></i>
                        <span>400-123-4567</span>
                    </div>
                    <div class="info-item">
                        <i class="fas fa-envelope"></i>
                        <span>contact@medicalcenter.com</span>
                    </div>
                    <div class="info-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <span>北京市海淀区医疗科技园区A座</span>
                    </div>
                    <div class="info-item">
                        <i class="fas fa-globe"></i>
                        <span>www.medicalcenter.com</span>
                    </div>
                </div>
                
                <div class="qr-code">
                    <div class="qr-code-box">
                        <div id="qrcode" class="qr-code-img"></div>
                    </div>
                    <p>扫码关注我们的公众号</p>
                </div>
            </div>
            
            <div class="logo">
                <div class="logo-icon">
                    <i class="fas fa-heartbeat"></i>
                </div>
                <div class="logo-text">医疗科技中心</div>
            </div>
        </div>
        
        <div class="background-elements">
            <div class="dna-helix"></div>
            <div class="heartbeat-line"></div>
            <div class="circle-element circle-1"></div>
            <div class="circle-element circle-2"></div>
            <div class="medical-cross"></div>
        </div>
    </div>

    <script>
        // 简单的QR码生成函数
        function generateQRCode() {
            const qrCodeContainer = document.getElementById('qrcode');
            
            // 创建一个简单的QR码图案（这里用HTML/CSS模拟）
            const size = 180;
            const cellSize = 9;
            const grid = document.createElement('div');
            grid.style.display = 'grid';
            grid.style.gridTemplateColumns = `repeat(${size/cellSize}, 1fr)`;
            grid.style.width = '100%';
            grid.style.height = '100%';
            
            // 创建QR码图案
            for (let i = 0; i < (size/cellSize) * (size/cellSize); i++) {
                const cell = document.createElement('div');
                // 随机生成黑白格子，模拟QR码
                if (Math.random() > 0.7) {
                    cell.style.backgroundColor = '#000';
                } else {
                    cell.style.backgroundColor = '#fff';
                }
                grid.appendChild(cell);
            }
            
            // 添加QR码中心的标志
            const centerStart = Math.floor((size/cellSize)/2) - 3;
            const centerElements = [
                centerStart * (size/cellSize) + centerStart,
                centerStart * (size/cellSize) + centerStart + 1,
                centerStart * (size/cellSize) + centerStart + 2,
                (centerStart+1) * (size/cellSize) + centerStart,
                (centerStart+1) * (size/cellSize) + centerStart + 2,
                (centerStart+2) * (size/cellSize) + centerStart,
                (centerStart+2) * (size/cellSize) + centerStart + 1,
                (centerStart+2) * (size/cellSize) + centerStart + 2
            ];
            
            centerElements.forEach(index => {
                if (grid.children[index]) {
                    grid.children[index].style.backgroundColor = '#1A7BB7';
                }
            });
            
            qrCodeContainer.appendChild(grid);
        }
        
        // 页面加载完成后生成QR码
        window.addEventListener('DOMContentLoaded', generateQRCode);
    </script>
</body>
</html>
```
