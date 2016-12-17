%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{cv}[2016/11/16 CV class containing various formatting elements]

\NeedsTeXFormat{LaTeX2e}

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax

\LoadClass{article}

\RequirePackage[\cvlanguage]{babel}
\RequirePackage[sfdefault]{ClearSans}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{parskip}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage{marvosym}
\RequirePackage{smartdiagram}
\RequirePackage{fontspec}
\RequirePackage{makecell}
\RequirePackage{xstring} % IfEqCase

%%%%%%%%%%%%%%%%%%%%%%%
% MISC CONFIGURATIONS %
%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[hidelinks]{hyperref} % hidden hyperlinks

\RequirePackage{ragged2e} % text alignment - left blocked

\RequirePackage[left=7.6cm,top=0.1cm,right=1cm,bottom=0.2cm,nohead,nofoot]{geometry}

\pagestyle{empty} % Disable headers and footers

\setlength{\parindent}{0pt} % Disable paragraph indentation

%%%%%%%%%%%%%%
% Side Block %
%%%%%%%%%%%%%%

\newenvironment{aside}{%
    \begin{tikzpicture}[remember picture, overlay]%
        \node [rectangle, fill=sidecolor, anchor=north, minimum width=9cm, minimum height=\paperheight+1cm] (box) at (-5cm,0.5cm){};%
    \end{tikzpicture}%
    \begin{textblock}{6}(0.5, 0.2)%
}{%
    \end{textblock}%
}

%%%%%%%%%%%%%%%%%%%
% Profile Picture %
%%%%%%%%%%%%%%%%%%%

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{\cvprofilepicturesize}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}

\newcommand{\profilepic}[1]{%
    \begin{center}%
        \begin{tikzpicture}[x=\imagescale,y=-\imagescale]%
            \clip (600/2, 567/2) circle (567/2);%
            \node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) {\includegraphics[width=\imagewidth]{#1}};%
        \end{tikzpicture}%
    \end{center}%
}

%%%%%%%%%%%%%%%%%%%%%%%
% CV NAME & JOB TITLE %
%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\cvname}[1]{%
    {\fontsize{23.4}{0}\selectfont\color{maincolor}#1}%
}

\newcommand{\cvjobtitle}[1]{%
    {\Large#1}%
}

%%%%%%%%%%%
% CV INFO %
%%%%%%%%%%%

\newenvironment{cvinfo}{%
    \renewcommand{\arraystretch}{1.6}%
    \begin{tabular}{m{0.5cm} @{\hskip 0.5cm}m{5cm}}%
}{%
    \end{tabular}%
}
    
\newcommand{\cvdate}[1]{    %
    \textsc{\Large\icon{\Info}} & #1%
}

\newcommand{\cvmail}[1]{%
    \textsc{\large\icon{@}} & \href{mailto:#1}{#1}%
}

\newcommand{\cvnumberphone}[1]{%
    \textsc{\Large\icon{\Telefon}} & #1%
}

\newcommand{\cvaddress}[1]{%
    \vspace{-21pt}\textsc{\Large\icon{\Letter}} & #1%
}

\newcommand{\cvsite}[1]{%
    \textsc{\Large\icon{\Mundus}} & \href{https://#1}{#1}%
}

\newcommand{\cvlinkedin}[1]{%
    \tikz[baseline=(char.base)]{\node[circle, draw, inner sep=0pt, minimum size=18.7pt, fill=maincolor, text=white, path picture={\node at (path picture bounding box.center){\includegraphics[scale=0.013]{images/logos/linkedin}};}, maincolor]{}; } & \href{https://#1}{#1}%
}

\newcommand{\cvgitsite}[1]{%
    \tikz[baseline=(char.base)]{\node[circle, draw, inner sep=0pt, minimum size=18.7pt, fill=maincolor, text=white, path picture={\node at (path picture bounding box.center){\includegraphics[scale=0.08]{images/logos/git}};}, maincolor]{}; } & \href{https://#1}{#1}% 
}

% Command for printing the contact information icons
\newcommand*\icon[1]{%
    \tikz[baseline=(char.base)]{\node[shape=circle,draw,inner sep=1pt, minimum size=18.7pt,fill=maincolor,maincolor,text=iconsymbolcolor] (char) {#1};}%
}

%%%%%%%%%%%%%%%%%%%
% PROFILE SECTION %
%%%%%%%%%%%%%%%%%%%

\newcommand{\profilesection}[3]{%
    \vspace{8pt}{\color{textcolor} \huge #1 \rule[0.15\baselineskip]{#2}{1pt}}
    \vspace{-2pt}
    
    #3%
}

%%%%%%%%%%%%%%%%%
% SMART DIAGRAM %
%%%%%%%%%%%%%%%%%

\smartdiagramset{
    bubble center node font = \footnotesize,
    bubble node font = \footnotesize,
    bubble center node size = 2.8cm,
    bubble node size = 1.2cm,
    distance center/other bubbles = 0.3cm,
    distance text center bubble = 0.2cm,
    bubble center node color = maincolor,
    set color list = {materialcyan, orange, green, materialorange, materialamber, materialteal, materialyellow, materialgreen, materiallime, materialpurple, materialblue},
    bubble fill opacity = 0.7,
    bubble text opacity = 0.8,
}

%%%%%%%%%
% SCORE %
%%%%%%%%%
% Thanks to Jake for posting this snippet on stack exchange!
% https://tex.stackexchange.com/questions/11390/drawing-stars-similar-with-tikz

\usetikzlibrary{shapes.geometric}

\newcommand\score[2]{%
    \vspace{-9pt}%
    \pgfmathsetmacro\pgfxa{#1+1}%
    \tikzstyle{scorestars}=[star, star points=5, star point ratio=2.25, draw,inner sep=1.8pt,anchor=outer point 3]%
    \begin{tikzpicture}[baseline]%
        \foreach \i in {1,...,#2} {%
            \pgfmathparse{(\i<=#1?"starcolor":"lightgray")}%
            \edef\starcolor{\pgfmathresult}%
            \draw[white] (\i*2.5ex,0) node[name=star\i,scorestars,fill=\starcolor]  {};%
        }%
    \end{tikzpicture}%
}
 
%%%%%%%%%%%
% SECTION %
%%%%%%%%%%%

\newcounter{colorCounter}

\def\@sectioncolor#1#2#3{%
    {%
        \color{%
            \ifcase\value{colorCounter}%
            maincolor\or%
            maincolor\or%
            maincolor\or%
            maincolor\or%
            maincolor\else%
            maincolor\fi%
        } #1#2#3%
    }%
    \stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{%
    \par\vspace{\parskip}%
    {%
        \LARGE\color{textcolor}%
        \@sectioncolor #1%
    }%
    \par\vspace{\parskip}%
}  

%%%%%%%%%%%%%%%%%%%%
% LIST ENVIRONMENT %
%%%%%%%%%%%%%%%%%%%%

\setlength{\tabcolsep}{0pt}
\newenvironment{entrylist}{%
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}%
}{%
    \end{tabular*}%
}

\newcommand{\entry}[4]{%
    #1&\parbox[t]{9.7cm}{
        \textbf{#2}\vspace{3pt}
        \hfill
        {\fontsize{8}{0}\selectfont\addfontfeature{Color=maincolor} #3}\\
        #4\vspace{\entryspacing}
    }\\
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LIST ENVIRONMENT - SIDE BAR %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\entrysidebar}[2]{%
    \parbox[t]{6.0cm}{
        \textbf{#1}\vspace{3pt}\\
        #2\vspace{\entryspacing}
    }\\
}

%%%%%%%%%
% BOXUP %
%%%%%%%%%

\newsavebox\myboxup
\newlength\myboxuplength
\newcommand\boxup[3][t]{%
    \IfEqCase{#1}{%
        {t}{\savebox\myboxup{#2}}%
        {b}{\savebox\myboxup{#3}}%
    }[\PackageError{boxup}{Undefined option to boxup: #1}{}]%
    \setlength\myboxuplength{\wd\myboxup}%
    \parbox[t]{\myboxuplength}{#2 \\ #3}%
}

%%%%%%%%%%
% COLORS %
%%%%%%%%%%

\definecolor{white}             {HTML}{FFFFFF}
\definecolor{darkgray}          {HTML}{333333}
\definecolor{gray}              {HTML}{4D4D4D}
\definecolor{lightgray}         {HTML}{999999}
\definecolor{green}             {HTML}{C2E15F}
\definecolor{orange}            {HTML}{FDA333}
\definecolor{purple}            {HTML}{D3A4F9}
\definecolor{red}               {HTML}{FB4485}
\definecolor{blue}              {HTML}{6CE0F1}
\definecolor{pblue}             {HTML}{0395DE}
\definecolor{materialpurple}    {HTML}{9C27B0}
\definecolor{materialyellow}    {HTML}{FFEB3B}
\definecolor{materialblue}      {HTML}{2196F3}
\definecolor{materialcyan}      {HTML}{00BCD4}
\definecolor{materialteal}      {HTML}{009688}
\definecolor{materialgreen}     {HTML}{4CAF50}
\definecolor{materiallime}      {HTML}{CDDC39}
\definecolor{materialamber}     {HTML}{FFC107}
\definecolor{materialbrown}     {HTML}{795548}
\definecolor{materialred}       {HTML}{FF4436}
\definecolor{materialorange}    {HTML}{FF5722}
