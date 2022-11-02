;open device manager
;ctrl+Shift+D
^+d::
Run, devmgmt.msc
;SEND, devmgmt.msc
;SEND, {ENTER}
return

::rdevman::
Run, devmgmt.msc
return

::rnp::
Run, notepad.exe
return

::rcmd::
Run, cmd
return
 

;====AHKScripting====
::[CTRL::{^}
::[ALT::{!}
::[SHIFT::{+}a
::[WIN::{#}


;This auto correct the wrong words into the correct one
;::WRONG::CORRECT

;=====all void wording=====
::vodi::void
::viod::void
::vdio::void
::coid::void
::ciod::void

;===Arduino serial must be dcaptial===
::serial::Serial
::serail::Serial
::sreial::Serial

;===write===
::wirite::write
::wirete::write
::wirte::write

;======char====
::chra::char

;=======define=====
::defnei::define
::defien::define
::defnie::define
::defein::define
::defeni::define
::dfeine::define
::#def::{#}define

;======include=====
::inlucde::include
::inlcude::include
::incudel::include
::#inc::{#}include
::nilcude::include
::incdule::include
::icnldue::include
::icnlduie::include
::icnldeu::include
::inuclde::include

;=====init==dev===
::initJS::function OnStart(){{}`n`n}
::initC::int main(){{}`n`n`treturn 0;`n{}}
::initembC::int main(){{}while(1){{}{}}{}}

;====time====
::helpTime::
(
uint32_t StartTime;
uint32_t CurrentTime;
uint32_t ElapsedTime;
CurrentTime = millis();
ElapsedTime = CurrentTime - StartTime;
)

;===helpStruct====
::helpStruct::
(
struct Ball {
    char color[10];
    double radius;
} ball1 = {"red", 5.0}, ball2;
)

:*?b0:(::){LEFT}
:*?b0:{::{}}{LEFT}

:*?b:`;`;::
Send, {End}
Send, `;
return

^9::Send, (){{}`n`n`n {UP}{UP}{UP}{END}{LEFT}{LEFT}

;====for=====
::ffor::for(int i = 0{;} i < xxx {;} i{+}{+}){{}`n`n