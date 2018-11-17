
//Be sure to have turbo pascal on

program monopoly;


type
	sets = set of 1..41;
	
	stuff = record
	name,typ: string;
	houses, group, groupno,price,hprice, owned,gown,color,amount,ownedno: integer;
	rent: array[0..5] of integer;
	end;

var
	u,set1: sets;
	owned: array[0..41,1..4] of string;
	RRcounter,UTcounter,RRmoney: array[1..4] of integer;
	colcounter: array[1..4,1..8] of integer;
	community, chance: array[1..16] of integer;
	spots,money,randoms,used,ownedcounter,jail: array[1..4] of integer;
	spaces: array[1..42] of stuff;
	loc: array[1..42,1..4] of char;
	tnames,names: array[1..4] of string;
	gcounter: array[1..10] of integer;
	x,y,z,players,valid,num,extra,r1,r2,done,win,doubles,trigger,choicenum,house: integer;
	choice: char;
	
procedure dice(num1, num2: integer); //The dice
	begin
	if (num1=1) then begin
	writeln(' ______');
	writeln('|      |');
	writeln('|   o  |');
	writeln('|      |');
	writeln('|______|');
	end;
	if (num1=2) then begin
	writeln(' ______');
	writeln('|      |');
	writeln('|    o |');
	writeln('| o    |');
	writeln('|______|');
	end;
	if (num1=3) then begin
	writeln(' ______');
	writeln('|     o|');
	writeln('|   o  |');
	writeln('| o    |');
	writeln('|______|');
	end;
	if (num1=4) then begin
	writeln(' ______');
	writeln('| o  o |');
	writeln('|      |');
	writeln('| o  o |');
	writeln('|______|');
	end;
	if (num1=5) then begin
	writeln(' ______');
	writeln('| o   o|');
	writeln('|   o  |');
	writeln('| o   o|');
	writeln('|______|');
	end;
	if (num1=6) then begin
	writeln(' ______');
	writeln('| o o o|');
	writeln('|      |');
	writeln('| o o o|');
	writeln('|______|');
	end;
	writeln;
	if (num2=1) then begin
	writeln(' ______');
	writeln('|      |');
	writeln('|   o  |');
	writeln('|      |');
	writeln('|______|');
	end;
	if (num2=2) then begin
	writeln(' ______');
	writeln('|      |');
	writeln('|    o |');
	writeln('| o    |');
	writeln('|______|');
	end;
	if (num2=3) then begin
	writeln(' ______');
	writeln('|     o|');
	writeln('|   o  |');
	writeln('| o    |');
	writeln('|______|');
	end;
	if (num2=4) then begin
	writeln(' ______');
	writeln('| o  o |');
	writeln('|      |');
	writeln('| o  o |');
	writeln('|______|');
	end;
	if (num2=5) then begin
	writeln(' ______');
	writeln('| o   o|');
	writeln('|   o  |');
	writeln('| o   o|');
	writeln('|______|');
	end;
	if (num2=6) then begin
	writeln(' ______');
	writeln('| o o o|');
	writeln('|      |');
	writeln('| o o o|');
	writeln('|______|');
	end;
end;
	
begin
	(******************************) //Entering all the stuff
	RRmoney[1]:=25;
	RRmoney[2]:=50;
	RRmoney[3]:=100;
	RRmoney[4]:=200;
	spaces[1].name:='Go';
	spaces[1].typ:='Go';
	spaces[2].name:='Mediterranean Ave';
	spaces[2].typ:='Prop';
	spaces[2].rent[0]:=2;
	spaces[2].rent[1]:=10;
	spaces[2].rent[2]:=30;
	spaces[2].rent[3]:=90;
	spaces[2].rent[4]:=160;
	spaces[2].rent[5]:=250;
	spaces[2].price:=60;
	spaces[2].hprice:=50;
	spaces[2].color:=1;
	spaces[2].amount:=2;
	spaces[3].name:='Community Chest';
	spaces[3].typ:='CC';
	spaces[4].name:='Baltic Ave';
	spaces[4].typ:='Prop';
	spaces[4].rent[0]:=4;
	spaces[4].rent[1]:=20;
	spaces[4].rent[2]:=60;
	spaces[4].rent[3]:=180;
	spaces[4].rent[4]:=320;
	spaces[4].rent[5]:=450;
	spaces[4].price:=60;
	spaces[4].hprice:=50;
	spaces[4].color:=1;
	spaces[4].amount:=2;
	spaces[5].name:='Income Tax';
	spaces[5].typ:='Income Tax';
	spaces[6].name:='Reading Railroad';
	spaces[6].typ:='RR';
	spaces[6].price:=200;
	spaces[7].name:='Oriental Ave';
	spaces[7].typ:='Prop';
	spaces[7].rent[0]:=6;
	spaces[7].rent[1]:=30;
	spaces[7].rent[2]:=90;
	spaces[7].rent[3]:=270;
	spaces[7].rent[4]:=400;
	spaces[7].rent[5]:=550;
	spaces[7].price:=100;
	spaces[7].hprice:=50;
	spaces[7].color:=2;
	spaces[7].amount:=3;
	spaces[8].name:='Chance';
	spaces[8].typ:='Chance';
	spaces[9].name:='Vermont Ave';
	spaces[9].typ:='Prop';
	spaces[9].rent[0]:=6;
	spaces[9].rent[1]:=30;
	spaces[9].rent[2]:=90;
	spaces[9].rent[3]:=270;
	spaces[9].rent[4]:=400;
	spaces[9].rent[5]:=550;
	spaces[9].price:=100;
	spaces[9].hprice:=50;
	spaces[9].color:=2;
	spaces[9].amount:=3;
	spaces[10].name:='Connecticut Ave';
	spaces[10].typ:='Prop';
	spaces[10].rent[0]:=8;
	spaces[10].rent[1]:=40;
	spaces[10].rent[2]:=100;
	spaces[10].rent[3]:=300;
	spaces[10].rent[4]:=450;
	spaces[10].rent[5]:=600;
	spaces[10].price:=120;
	spaces[10].hprice:=50;
	spaces[10].color:=2;
	spaces[10].amount:=3;
	spaces[11].name:='Jail: Just Visiting';
	spaces[11].typ:='Visiting';
	spaces[12].name:='Jail';
	spaces[12].typ:='Jail';
	spaces[13].name:='St. Charles Place';
	spaces[13].typ:='Prop';
	spaces[13].rent[0]:=10;
	spaces[13].rent[1]:=50;
	spaces[13].rent[2]:=150;
	spaces[13].rent[3]:=450;
	spaces[13].rent[4]:=625;
	spaces[13].rent[5]:=750;
	spaces[13].price:=140;
	spaces[13].hprice:=100;
	spaces[13].color:=3;
	spaces[13].amount:=3;
	spaces[14].name:='Electric Company';
	spaces[14].typ:='Utility';
	spaces[14].price:=150;
	spaces[15].name:='States Ave';
	spaces[15].typ:='Prop';
	spaces[15].rent[0]:=10;
	spaces[15].rent[1]:=50;
	spaces[15].rent[2]:=150;
	spaces[15].rent[3]:=450;
	spaces[15].rent[4]:=625;
	spaces[15].rent[5]:=750;
	spaces[15].price:=140;
	spaces[15].hprice:=100;
	spaces[15].color:=3;
	spaces[15].amount:=3;
	spaces[16].name:='Virginia Ave';
	spaces[16].typ:='Prop';
	spaces[16].rent[0]:=12;
	spaces[16].rent[1]:=60;
	spaces[16].rent[2]:=180;
	spaces[16].rent[3]:=500;
	spaces[16].rent[4]:=700;
	spaces[16].rent[5]:=900;
	spaces[16].price:=160;
	spaces[16].hprice:=100;
	spaces[16].color:=3;
	spaces[16].amount:=3;
	spaces[17].name:='Pennsylvania RailRoad';
	spaces[17].typ:='RR';
	spaces[17].price:=200;
	spaces[18].name:='St. James Place';
	spaces[18].typ:='Prop';
	spaces[18].rent[0]:=14;
	spaces[18].rent[1]:=70;
	spaces[18].rent[2]:=200;
	spaces[18].rent[3]:=550;
	spaces[18].rent[4]:=750;
	spaces[18].rent[5]:=950;
	spaces[18].price:=180;
	spaces[18].hprice:=100;
	spaces[18].color:=4;
	spaces[18].amount:=3;
	spaces[19].name:='Community Chest';
	spaces[19].typ:='CC';
	spaces[20].name:='Tennessee Ave';
	spaces[20].typ:='Prop';
	spaces[20].rent[0]:=14;
	spaces[20].rent[1]:=70;
	spaces[20].rent[2]:=200;
	spaces[20].rent[3]:=550;
	spaces[20].rent[4]:=750;
	spaces[20].rent[5]:=950;
	spaces[20].price:=180;
	spaces[20].hprice:=100;
	spaces[20].color:=4;
	spaces[20].amount:=3;
	spaces[21].name:='New York Ave';
	spaces[21].typ:='Prop';
	spaces[21].rent[0]:=16;
	spaces[21].rent[1]:=80;
	spaces[21].rent[2]:=220;
	spaces[21].rent[3]:=600;
	spaces[21].rent[4]:=800;
	spaces[21].rent[5]:=1000;
	spaces[21].price:=200;
	spaces[21].hprice:=100;
	spaces[21].color:=4;
	spaces[21].amount:=3;
	spaces[22].name:='Free Parking';
	spaces[22].typ:='Free Parking';
	spaces[23].name:='Kentucky Ave';
	spaces[23].typ:='Prop';
	spaces[23].rent[0]:=18;
	spaces[23].rent[1]:=90;
	spaces[23].rent[2]:=250;
	spaces[23].rent[3]:=700;
	spaces[23].rent[4]:=875;
	spaces[23].rent[5]:=1050;
	spaces[23].price:=220;
	spaces[23].hprice:=150;
	spaces[23].color:=5;
	spaces[23].amount:=3;
	spaces[24].name:='Chance';
	spaces[24].typ:='Chance';
	spaces[25].name:='Indiana Ave';
	spaces[25].typ:='Prop';
	spaces[25].rent[0]:=18;
	spaces[25].rent[1]:=90;
	spaces[25].rent[2]:=250;
	spaces[25].rent[3]:=700;
	spaces[25].rent[4]:=875;
	spaces[25].rent[5]:=1050;
	spaces[25].price:=220;
	spaces[25].hprice:=150;
	spaces[25].color:=5;
	spaces[25].amount:=3;
	spaces[26].name:='Illinois Ave';
	spaces[26].typ:='Prop';
	spaces[26].rent[0]:=20;
	spaces[26].rent[1]:=100;
	spaces[26].rent[2]:=300;
	spaces[26].rent[3]:=750;
	spaces[26].rent[4]:=925;
	spaces[26].rent[5]:=1100;
	spaces[26].price:=240;
	spaces[26].hprice:=150;
	spaces[26].color:=5;
	spaces[26].amount:=3;
	spaces[27].name:='B&0 RailRoad';
	spaces[27].typ:='RR';
	spaces[27].price:=200;
	spaces[28].name:='Atlantic Ave';
	spaces[28].typ:='Prop';
	spaces[28].rent[0]:=22;
	spaces[28].rent[1]:=110;
	spaces[28].rent[2]:=330;
	spaces[28].rent[3]:=800;
	spaces[28].rent[4]:=975;
	spaces[28].rent[5]:=1150;
	spaces[28].price:=260;
	spaces[28].hprice:=150;
	spaces[28].color:=6;
	spaces[28].amount:=3;
	spaces[29].name:='Ventnor Ave';
	spaces[29].typ:='Prop';
	spaces[29].rent[0]:=22;
	spaces[29].rent[1]:=110;
	spaces[29].rent[2]:=330;
	spaces[29].rent[3]:=800;
	spaces[29].rent[4]:=975;
	spaces[29].rent[5]:=1150;
	spaces[29].price:=260;
	spaces[29].hprice:=150;
	spaces[29].color:=6;
	spaces[29].amount:=3;
	spaces[30].name:='Water Works';
	spaces[30].typ:='Utility';
	spaces[30].price:=150;
	spaces[31].name:='Marvin Gardens';
	spaces[31].typ:='Prop';
	spaces[31].rent[0]:=24;
	spaces[31].rent[1]:=120;
	spaces[31].rent[2]:=360;
	spaces[31].rent[3]:=850;
	spaces[31].rent[4]:=1025;
	spaces[31].rent[5]:=1200;
	spaces[31].price:=280;
	spaces[31].hprice:=150;
	spaces[31].color:=6;
	spaces[31].amount:=3;
	spaces[32].name:='Go To Jail';
	spaces[32].typ:='Go To Jail';
	spaces[33].name:='Pacific Avenue';
	spaces[33].typ:='Prop';
	spaces[33].rent[0]:=26;
	spaces[33].rent[1]:=130;
	spaces[33].rent[2]:=390;
	spaces[33].rent[3]:=900;
	spaces[33].rent[4]:=1100;
	spaces[33].rent[5]:=1250;
	spaces[33].price:=300;
	spaces[33].hprice:=200;
	spaces[33].color:=7;
	spaces[33].amount:=3;
	spaces[34].name:='North Carolina Avenue';
	spaces[34].typ:='Prop';
	spaces[34].rent[0]:=26;
	spaces[34].rent[1]:=130;
	spaces[34].rent[2]:=390;
	spaces[34].rent[3]:=900;
	spaces[34].rent[4]:=1100;
	spaces[34].rent[5]:=1250;
	spaces[34].price:=300;
	spaces[34].hprice:=200;
	spaces[34].color:=7;
	spaces[34].amount:=3;
	spaces[35].name:='Community Chest';
	spaces[35].typ:='CC';
	spaces[36].name:='Pennsylvania Avenue';
	spaces[36].typ:='Prop';
	spaces[36].rent[0]:=28;
	spaces[36].rent[1]:=150;
	spaces[36].rent[2]:=450;
	spaces[36].rent[3]:=1000;
	spaces[36].rent[4]:=1200;
	spaces[36].rent[5]:=1400;
	spaces[36].price:=300;
	spaces[36].hprice:=200;
	spaces[36].color:=7;
	spaces[36].amount:=3;
	spaces[37].name:='Short Line';
	spaces[37].typ:='RR';
	spaces[37].price:=200;
	spaces[38].name:='Chance';
	spaces[38].typ:='Chance';
	spaces[39].name:='Park Place';
	spaces[39].typ:='Prop';
	spaces[39].rent[0]:=35;
	spaces[39].rent[1]:=175;
	spaces[39].rent[2]:=500;
	spaces[39].rent[3]:=1100;
	spaces[39].rent[4]:=1300;
	spaces[39].rent[5]:=1500;
	spaces[39].price:=350;
	spaces[39].hprice:=200;
	spaces[39].color:=8;
	spaces[39].amount:=2;
	spaces[40].name:='Luxury Tax';
	spaces[40].typ:='Lux';
	spaces[41].name:='Boardwalk';
	spaces[41].typ:='Prop';
	spaces[41].rent[0]:=50;
	spaces[41].rent[1]:=200;
	spaces[41].rent[2]:=600;
	spaces[41].rent[3]:=1400;
	spaces[41].rent[4]:=1700;
	spaces[41].rent[5]:=2000;
	spaces[41].price:=400;
	spaces[41].hprice:=200;
	spaces[41].color:=8;
	spaces[41].amount:=2;
	
	
	(*********************************)
	
	writeln('Welcome to Monopoly, otherwise known as Monoply.');
	writeln;
	randomize;
	num:=1;
	u:=[1..41];
	
	

	repeat
	
	writeln('How many players do you want to have? (2-4)');
	readln(players);
	writeln;
	

	
	until (players>1) and (players<5);							//Reading in names
	for x:=1 to players do begin
		repeat
			valid:=0;
			writeln('What is player ',x:0,'s name?');
			readln(tnames[x]);
			writeln;
			tnames[x][1]:=upcase(tnames[x][1]);
			if (tnames[x][1]=tnames[x-1][1]) or (tnames[x][1]=tnames[x-2][1]) or (tnames[x][1]=tnames[x-3][1]) or (tnames[x][1]=tnames[x+1][1]) or (tnames[x][1]=tnames[x+2][1]) or (tnames[x][1]=tnames[x+3][1]) or (tnames[x][1]=' ') then writeln('Choose a name with a different letter.')
			else valid:=1;
		until (valid=1);
	end;		
	
	for x:=1 to players do begin								//Randomizing name order
		repeat
			randoms[x]:=random(players)+1;
		until (used[randoms[x]]=0);
		used[randoms[x]]:=1;
		names[x]:=tnames[randoms[x]];
	end;
	
	for x:=1 to players do begin
		spots[x]:=1;
		money[x]:=2000;
	end;	  
	(*****************************)

repeat

	trigger:=0;
	done:=0;

	
													//Rolling the dice
if (jail[num]=0) then begin
	writeln;
	writeln;	
	writeln(names[num],' press enter to roll the dice.');
	readln;
	r1:=random(6)+1;
	r2:=random(6)+1;
	
	dice(r1, r2); 
	//readln(r1,r2);
	writeln('You rolled a ',r1+r2:0,'. (press enter)');
	if (r1<>r2) then doubles:=0;
	if (r1=r2) then begin
	writeln('You also rolled doubles!');
	doubles:=doubles+1;
	if (doubles=3) then begin
		writeln('You have rolled doubles 3 times in a row and must go to Jail for some reason.');
		doubles:=0;
		jail[num]:=1;
		spots[num]:=12;
		done:=1;
	end;	
	end;
	readln;
	
	
	if (jail[num]=0) then begin
	for x:=1 to r1+r2 do begin														//Starts the moving process
		spots[num]:=1+spots[num];
		if (spots[num]=12) then spots[num]:=13;	//Moves you off of jail
		if (spots[num]=42) then begin spots[num]:=1; money[num]:=money[num]+200; end; //Adds money for Go
	end;
	end;
end;
	
	
	
	for x:=1 to 4 do begin										//Placing locations
		for y:=1 to 42  do begin
			if spots[x]=y then loc[y,x]:=names[x][1]
			else loc[y,x]:=' ';
		end;
	end;		
	for x:=1 to 300 do begin
	writeln;
	end;
			
	writeln(' _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____'); //The Board.
	writeln('|Free |Kent |Chnce|India|Ilion|B&O  |Atlan|Vntnr|Water|Marvn|Go To|');
	writeln('|Park |Ave. |     |Ave. |Ave. |RRoad|Ave. |Ave. |Works|Grdns|Jail!|');
	writeln('|     |h=',spaces[23].houses:0,'  |  ?  |h=',spaces[25].houses:0,'  |h=',spaces[26].houses:0,'  |  ',char(4),'  |h=',spaces[28].houses:0,'  |h=',spaces[29].houses:0,'  |     |h=',spaces[31].houses:0,'  |     |');
	writeln('|',loc[22,1],loc[22,2],loc[22,3],loc[22,4],' |',loc[23,1],loc[23,2],loc[23,3],loc[23,4],' |',loc[24,1],loc[24,2],loc[24,3],loc[24,4],' |',loc[25,1],loc[25,2],loc[25,3],loc[25,4],' |',loc[26,1],loc[26,2],loc[26,3],loc[26,4],' |',loc[27,1],loc[27,2],loc[27,3],loc[27,4],' |',loc[28,1],loc[28,2],loc[28,3],loc[28,4],' |',loc[29,1],loc[29,2],loc[29,3],loc[29,4],' |',loc[30,1],loc[30,2],loc[30,3],loc[30,4],' |',loc[31,1],loc[31,2],loc[31,3],loc[31,4],' |',loc[32,1],loc[32,2],loc[32,3],loc[32,4],' |');
	writeln('|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|');
	writeln('|NYork|                                                     |Pacif|');
	writeln('|Ave. |                                                     |Ave. |');
	writeln('|h=',spaces[21].houses:0,'  |                                                     |h=',spaces[33].houses:0,'  |');
	writeln('|',loc[21,1],loc[21,2],loc[21,3],loc[21,4],' |                                                     |',loc[33,1],loc[33,2],loc[33,3],loc[33,4],' |');
	writeln('|_____|                                                     |_____|');
	writeln('|Tenn.|                                                     |NCarl|');
	writeln('|Ave. |                                                     |Ave. |');
	writeln('|h=',spaces[20].houses:0,'  |                                                     |h=',spaces[34].houses:0,'  |');
	writeln('|',loc[20,1],loc[20,2],loc[20,3],loc[20,4],' |                                                     |',loc[34,1],loc[34,2],loc[34,3],loc[34,4],' |');
	writeln('|_____|                                                     |_____|');
	writeln('|Comm |                                                     |Comm |');
	writeln('|Chest|                                                     |Chest|');
	writeln('| $$$ |                                                     |     |');
	writeln('|',loc[19,1],loc[19,2],loc[19,3],loc[19,4],' |                                                     |',loc[35,1],loc[35,2],loc[35,3],loc[35,4],' |');
	writeln('|_____|                                                     |_____|');
	writeln('|James|   __  __  ____  _   _  ____  _____  _  __     __    |Penn.|');
	writeln('|Place|  |  \/  |/ __ \| \ | |/ __ \|  __ \| | \ \   / /    |Ave. |');
	writeln('|h=',spaces[18].houses:0,'  |  | \  / | |  | |  \| | |  | | |__) | |  \ \_/ /     |h=',spaces[36].houses:0,'  |');
	writeln('|',loc[18,1],loc[18,2],loc[18,3],loc[18,4],' |  | |\/| | |  | | . ` | |  | |  ___/| |   \   /      |',loc[36,1],loc[36,2],loc[36,3],loc[36,4],' |');
	writeln('|_____|  | |  | | |__| | |\  | |__| | |    | |____| |       |_____|');
	writeln('|Penn.|  |_|  |_|\____/|_| \_|\____/|_|    |______|_|       |Short|');
	writeln('|RRoad|                                                     |Line |');
	writeln('|  ',char(4),'  |                                                     |  ',char(4),'  |');
	writeln('|',loc[17,1],loc[17,2],loc[17,3],loc[17,4],' |                                                     |',loc[37,1],loc[37,2],loc[37,3],loc[37,4],' |');
	writeln('|_____|                                                     |_____|');
	writeln('|Virgi|                                                     |Chnce|');
	writeln('|Ave. |                                                     |     |');
	writeln('|h=',spaces[16].houses:0,'  |                                                     |  ?  |');
	writeln('|',loc[16,1],loc[16,2],loc[16,3],loc[16,4],' |                                                     |',loc[38,1],loc[38,2],loc[38,3],loc[38,4],' |');
	writeln('|_____|                                                     |_____|');
	writeln('|State|                                                     |Park |');
	writeln('|Ave. |                                                     |Place|');
	writeln('|h=',spaces[15].houses:0,'  |                                                     |h=',spaces[39].houses:0,'  |');
	writeln('|',loc[15,1],loc[15,2],loc[15,3],loc[15,4],' |                                                     |',loc[39,1],loc[39,2],loc[39,3],loc[39,4],' |');
	writeln('|_____|                                                     |_____|');
	writeln('|Elec |                                                     |Luxry|');
	writeln('|Comp |                                                     |Tax  |');
	writeln('|     |                                                     |     |');
	writeln('|',loc[14,1],loc[14,2],loc[14,3],loc[14,4],' |                                                     |',loc[40,1],loc[40,2],loc[40,3],loc[40,4],' |');
	writeln('|_____|                                                     |_____|');
	writeln('|Charl|                                                     |Board|');
	writeln('|Place|                                                     |Walk |');
	writeln('|h=',spaces[13].houses:0,'  |                                                     |h=',spaces[41].houses:0,'  |');
	writeln('|',loc[13,1],loc[13,2],loc[13,3],loc[13,4],' |                                                     |',loc[41,1],loc[41,2],loc[41,3],loc[41,4],' |');
	writeln('|_____|_____ _____ _____ _____ _____ _____ _____ _____ _____|_____|');
	writeln('|Jail |Conn |Vermo|Chnce|Orent|Redng|Incom|Bltic|Comun|Medit|     |');
	writeln('|',loc[12,1],loc[12,2],loc[12,3],loc[12,4],' |Ave. |Ave. |     |Ave. |RRoad|Tax  |Ave. |Chest|Ave. |  GO |');
	writeln('|Visit|h=',spaces[10].houses:0,'  |h=',spaces[9].houses:0,'  |  ?  |h=',spaces[7].houses:0,'  |  ',char(4),'  |     |h=',spaces[4].houses:0,'  | $$$ |h=',spaces[2].houses:0,'  |<----|');
	writeln('|',loc[11,1],loc[11,2],loc[11,3],loc[11,4],' |',loc[10,1],loc[10,2],loc[10,3],loc[10,4],' |',loc[9,1],loc[9,2],loc[9,3],loc[9,4],' |',loc[8,1],loc[8,2],loc[8,3],loc[8,4],' |',loc[7,1],loc[7,2],loc[7,3],loc[7,4],' |',loc[6,1],loc[6,2],loc[6,3],loc[6,4],' |',loc[5,1],loc[5,2],loc[5,3],loc[5,4],' |',loc[4,1],loc[4,2],loc[4,3],loc[4,4],' |',loc[3,1],loc[3,2],loc[3,3],loc[3,4],' |',loc[2,1],loc[2,2],loc[2,3],loc[2,4],' |',loc[1,1],loc[1,2],loc[1,3],loc[1,4],' |');
	writeln('|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|');
	writeln;
	writeln(names[1]:16,names[2]:16,names[3]:16,names[4]:16); //Showing how much money each player has
	
	for x:=1 to players do begin
	write(money[x]:15,'$');
	end;
	
	writeln;
	
	
	for y:=0 to 41 do begin
		
		if (owned[y,1]<>'') or (owned[y,2]<>'') or (owned[y,3]<>'') or (owned[y,4]<>'') then begin
		write(' ':11);
		for x:=1 to players do begin
		
			for z:=1 to 15 do begin
				write(owned[y,x][z]);
			end;
			
			write(' ');
			
		end;
		writeln;
		end;
		
	end;		
					
	writeln;		
			
	(*****************************************)
	
	writeln(names[num],' landed on ',spaces[spots[num]].name,'.');
		if (spaces[spots[num]].owned=0) and ((spaces[spots[num]].typ='Prop') or (spaces[spots[num]].typ='RR') or (spaces[spots[num]].typ='Utility')) then begin
			writeln('Would you like to buy it for $',spaces[spots[num]].price:0,'? (y for yes, n for no)');
			readln(choice);
			
			if (choice='y') then begin									//Buying properties
				spaces[spots[num]].owned:=num;
				money[num]:=money[num]-spaces[spots[num]].price;
				owned[ownedcounter[num],num]:=spaces[spots[num]].name;
				ownedcounter[num]:=ownedcounter[num]+1;
				
				if (spaces[spots[num]].typ='Prop') then begin
					colcounter[num,spaces[spots[num]].color]:=colcounter[num,spaces[spots[num]].color]+1;
				end;
				
				if (spaces[spots[num]].typ='RR') then begin
					RRcounter[num]:=RRcounter[num]+1;
				end;
				
				if (spaces[spots[num]].typ='Utility') then begin
					UTcounter[num]:=UTcounter[num]+1;
				end;	
				
			end;
		end;
		
		if (spaces[spots[num]].owned<>0) and (spaces[spots[num]].owned<>num) and ((spaces[spots[num]].typ='Prop') or (spaces[spots[num]].typ='RR') or (spaces[spots[num]].typ='Utility')) then begin		
			
			if (spaces[spots[num]].typ='Prop') then begin																				//Paying to owners
				writeln('You pay $',spaces[spots[num]].rent[spaces[spots[num]].houses]:0,' to ',names[spaces[spots[num]].owned],'.');
				money[num]:=money[num]-spaces[spots[num]].rent[spaces[spots[num]].houses];
				money[spaces[spots[num]].owned]:=money[spaces[spots[num]].owned]+spaces[spots[num]].rent[spaces[spots[num]].houses];
			end;
			
			if (spaces[spots[num]].typ='RR') then begin
				writeln('You pay $',RRmoney[RRcounter[spaces[spots[num]].owned]]:0,' to ',names[spaces[spots[num]].owned],'.');
			end;	
		end;
		
		if (spaces[spots[num]].typ='Income Tax') then begin //Income tax
			writeln('You pay $200 for Income tax.');
			money[num]:=money[num]-200;
		end;
		
		if (spaces[spots[num]].typ='Lux') then begin //Luxury tax
			writeln('You pay $100 for Luxury tax.');
			money[num]:=money[num]-100;
		end;
		
		if (spaces[spots[num]].typ='Utility') and (spaces[spots[num]].owned<>num) then begin //Water works / Electric company
			if (UTcounter[spaces[spots[num]].owned]=1) then begin
				writeln('You pay $',(r1+r2)*4,' to ',names[spaces[spots[num]].owned],'.');
				money[num]:=money[num]-(r1+r2)*4;
				money[spaces[spots[num]].owned]:=money[spaces[spots[num]].owned]+(r1+r2)*4;
			end;
			if (UTcounter[spaces[spots[num]].owned]=2) then begin
				writeln('You pay $',(r1+r2)*10,' to ',names[spaces[spots[num]].owned],'.');
				money[num]:=money[num]-(r1+r2)*10;
				money[spaces[spots[num]].owned]:=money[spaces[spots[num]].owned]+(r1+r2)*10;
			end;				
		end;
		
		if (spaces[spots[num]].typ='Jail') then begin
			if (jail[num]<4) and (done=0) then begin
				
				repeat
				writeln('Would you like to pay 50$ to get out of jail?');
				readln(choice);
				if (choice='y') then begin
					jail[num]:=0;
					money[num]:=money[num]-50;
					spots[num]:=11;
				end;
				if (choice='n') then begin	
				writeln('Press enter to roll the dice. Doubles will get you out of Jail.');
				readln;
				r1:=random(6)+1;
				r2:=random(6)+1;
				dice(r1, r2);
				if (r1<>r2) then begin
					jail[num]:=jail[num]+1;
					writeln('You are still in Jail.');
				end;
				if (r1=r2) then begin
					writeln('You rolled doubles, and are out of Jail!');
					jail[num]:=0;
					spots[num]:=11;	
				end;
				end;
				until (choice='y') or (choice='n');
			end;
			
			if (jail[num]=4) then begin
				
				writeln('You have been in Jail for 3 turns and must pay $50 to get out of Jail.');
				money[num]:=money[num]-50;
				spots[num]:=11;
				jail[num]:=0;
			end;	
					 
		end;	
			
		
		
		if (spaces[spots[num]].typ='Go To Jail') then begin
			spots[num]:=12;
			writeln('You are now in Jail.');
			jail[num]:=1;
		end;	
	
	
	
	for x:=1 to 41 do begin
		if (spaces[x].owned=num) and (spaces[x].typ='Prop') and (colcounter[num,spaces[x].color]=spaces[x].amount) then trigger:=1;
	end;	
	
	if (trigger=1) then begin
	repeat
	writeln;
	writeln('Would you like to put houses on any properties?(y for yes, n for no)');
	readln(choice);
	writeln;
		
		if (choice='y') then begin
			writeln('Enter which number you would like to add houses to.');
			for x:=1 to 41 do begin
				if (spaces[x].owned=num) and (spaces[x].typ='Prop') and (colcounter[num,spaces[x].color]=spaces[x].amount) then begin
				writeln(spaces[x].name,':',x:2);
				set1:=set1+[x];
				end;
			end;	
				readln(choicenum);
					writeln;
					if (choicenum in set1) then begin
						writeln('How many houses do you want to put on it for $',spaces[spots[num]].hprice:0,'?');
						readln(house);
						writeln;
						if (house+spaces[choicenum].houses<=5) then begin
							spaces[choicenum].houses:=house+spaces[choicenum].houses;
							money[num]:=money[num]-spaces[choicenum].hprice*house;
						end
						else writeln('That is more houses than you can put on a property.');
						
						end;
					
					if not (choicenum in set1) then begin
						writeln;
						writeln('That is not one of the properties you can choose.');
					end;		
				
		end;
			
			set1:=[];		
			
	
	
	until (choice='n');
	end;
	
	if (doubles=0) then num:=num+1;								//Changing turns
	if (num>players) then num:=1;
	
	for x:=1 to players do begin
		if (money[x]<0) then begin
			win:=1;
			for y:=1 to players do begin
				if (money[y]>money[win]) then win:=y;
			end;
		end;		
				
	end;


	until(win<>0);
	writeln;
	writeln;
	writeln(names[win],' has won.');
	writeln;
	writeln(' Press Enter to continue');
	readln;
	
	


end.
