%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%         3 & 3 d.o.f. Soft finger          %%%%%%%
%%%%%%%           Simulator of grasping           %%%%%%%
%%%%%%%        2009/06/05    by K. Tahara         %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function OUT = soft22(IN)

%%%%%%%%%%%%%%% Input Parameter %%%%%%%%%%%%%%%
% 時間(Time)
time	=	IN(1);

% 速度(Velocity)
dq1		=	IN(2:3);
dq2		=	IN(4:5);
do		=	IN(6:8);

% 位置(Position)
q1		=	IN(9:10);
q2		=	IN(11:12);
o		=	IN(13:15);

% 初期姿勢
init_q1	=	IN(16:17);
init_q2	=	IN(18:19);
init_o	=	IN(20:22);

s_Dp	=	IN(23);
s_Dx	=	IN(24:25);

%%%%%%%%%%%%%%% Link Parameter %%%%%%%%%%%%%%%
% 長さ [m]
L11		=	0.070;
L12		=	0.055;

L21		=	0.070;
L22		=	0.055;

% リンク質量中心位置 [m]
Lg11	=	L11 / 2.0;
Lg12	=	L12 / 2.0;

Lg21	=	L21 / 2.0;
Lg22	=	L22 / 2.0;

% 根元距離 [m]
D		=	0.10;

% 質量 [kg]
M11		=	0.035;
M12		=	0.025;

M21		=	0.035;
M22		=	0.025;

% 慣性モーメント [k･gm^2]
I11		=	M11 * L11^2 / 12.0;
I12		=	M12 * L12^2 / 12.0;

I21		=	M21 * L21^2 / 12.0;
I22		=	M22 * L22^2 / 12.0;

% 指先半径 [m]
r1		=	0.015;
r2		=	0.015;

% 重力加速度
% g		=	9.801;
g		=	0.0;

%%%%%%%%%%%%%%% Object Parameter %%%%%%%%%%%%%%%
% 質量 [kg]
OM		=	0.05;

% サイズ(縦×横) [m]
O_ver	=	0.049;
O_side	=	0.049;

% 慣性モーメント [k･gm^2]
OI		=	OM * (O_ver^2 + O_side^2) / 12.0;

%%%%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%
% 初期リンク先端位置 [m]
init_x01	=	[L11 * cos(init_q1(1)) + L12 * cos(init_q1(1) + init_q1(2));     L11 * sin(init_q1(1)) + L12 * sin(init_q1(1) + init_q1(2))];
init_x02	=	[L21 * cos(init_q2(1)) + L22 * cos(init_q2(1) + init_q2(2)) + D; L21 * sin(init_q2(1)) + L22 * sin(init_q2(1) + init_q2(2))];

% 初期接触点(Y1,Y2) [m]
init_point1	= - (init_x01(1) - init_o(1)) * sin(init_o(3)) + (init_x01(2) - init_o(2)) * cos(init_o(3));
init_point2	= - (init_x02(1) - init_o(1)) * sin(init_o(3)) + (init_x02(2) - init_o(2)) * cos(init_o(3));

%%%%%%%%%%%%%%% ダイナミクス %%%%%%%%%%%%%%%
% 慣性行列 Hi(q)
H1		=	[M11 * Lg11^2 + M12 * (L11^2 + Lg12^2 + 2 * L11 * Lg12 * cos(q1(2))) + I11 + I12, M12 * (Lg12^2 + L11 * Lg12 * cos(q1(2))) + I12;
			M12 * (Lg12^2 + L11 * Lg12 * cos(q1(2))) + I12, M12 * Lg12^2 + I12];

H2		=	[M21 * Lg21^2 + M22 * (L21^2 + Lg22^2 + 2 * L21 * Lg22 * cos(q2(2))) + I21 + I22, M22 * (Lg22^2 + L21 * Lg22 * cos(q2(2))) + I22;
			M22 * (Lg22^2 + L21 * Lg22 * cos(q2(2))) + I22, M22 * Lg22^2 + I22];

% ｺﾘｵﾘ・遠心力を含む歪対称行列 S(q,dq)
S1		=	[- M12 * L11 * Lg12 * sin(q1(2)) * (2 * dq1(1) * dq1(2) + dq1(2)^2);
			M12 * L11 * Lg12 * sin(q1(2)) * dq1(1)^2];

S2		=	[- M22 * L21 * Lg22 * sin(q2(2)) * (2 * dq2(1) * dq2(2) + dq2(2)^2);
			M22 * L21 * Lg22 * sin(q2(2)) * dq2(1)^2];

% 物体質量・慣性モーメントを含む対角行列 Ho(z)
Ho		=	diag([OM, OM, OI]);

% Gravity term g(q)
G1		=	[- M11 * g * Lg11 * cos(q1(1)) - M12 * g * (L11 * cos(q1(1)) + Lg12*cos(q1(1) + q1(2)));
			 - M12 * g * Lg12 * cos(q1(1) + q1(2))];

G2		=	[- M21 * g * Lg21 * cos(q2(1)) - M22 * g * (L21 * cos(q2(1)) + Lg22 * cos(q2(1) + q2(2)));
			 - M22 * g * Lg22 * cos(q2(1) + q2(2))];

%%%%%%%%%%%% 幾何学式 =Position= %%%%%%%%%%%%
% リンクヤコビ行列
J01		=	[- L11 * sin(q1(1)) - L12 * sin(q1(1) + q1(2)), - L12 * sin(q1(1) + q1(2));
			   L11 * cos(q1(1)) + L12 * cos(q1(1) + q1(2)),   L12 * cos(q1(1) + q1(2))];

J02		=	[- L21 * sin(q2(1)) - L22 * sin(q2(1) + q2(2)), - L22 * sin(q2(1) + q2(2));
			   L21 * cos(q2(1)) + L22 * cos(q2(1) + q2(2)),   L22 * cos(q2(1) + q2(2))];

% 物体回転行列
rx		=	[  cos(o(3)); sin(o(3))];
ry		=	[- sin(o(3)); cos(o(3))];

drx		=	do(3) * [- sin(o(3));   cos(o(3))];
dry		=	do(3) * [- cos(o(3)); - sin(o(3))];

x		=	o(1:2);
dx		=	do(1:2);

% リンク先端座標 (x0i,y0i)
x01		=	[L11 * cos(q1(1)) + L12 * cos(q1(1) + q1(2));     L11 * sin(q1(1)) + L12 * sin(q1(1) + q1(2))];
x02		=	[L21 * cos(q2(1)) + L22 * cos(q2(1) + q2(2)) + D; L21 * sin(q2(1)) + L22 * sin(q2(1) + q2(2))];

% リンク先端速度(dx0i,dy0i)
dx01	=	J01 * dq1;
dx02	=	J02 * dq2;

% 法線方向変位
Dr1		=	r1 + O_side / 2.0 + rx' * (x01 - x);
Dr2		=	r2 + O_side / 2.0 - rx' * (x02 - x);

dDr1	=	abs(  drx' * (x01 - x) + rx' * (dx01 - dx));
dDr2	=	abs(- drx' * (x02 - x) - rx' * (dx02 - dx));

if(Dr1 < 0)
	Dr1 = 0;
end
if(Dr2 < 0)
	Dr2 = 0;
end

% 接触点座標 (xi,yi)
x1		=	x01 + r1 * rx;
x2		=	x02 - r2 * rx;

% 接触点距離 (Y1,Y2)
c1		=	init_point1 - r1 * (init_o(3) - init_q1(1) - init_q1(2));
c2		=	init_point2 - r2 * (pi - init_o(3) + init_q2(1) + init_q2(2));

Y1_tip	=	c1 + r1 * (o(3) - q1(1) - q1(2));
Y2_tip	=	c2 + r2 * (pi - o(3) + q2(1) + q2(2));
dY1_tip	=	r1 * (do(3) - dq1(1) - dq1(2));
dY2_tip	=	r2 * (- do(3) + dq2(1) + dq2(2));

Y1_obj	=	ry' * (x01 - x);
Y2_obj	=	ry' * (x02 - x);
dY1_obj	=	dry' * (x01 - x) + ry' * (dx01 - dx);
dY2_obj	=	dry' * (x02 - x) + ry' * (dx01 - dx);

% 接線方向変位（転がり）
Dt1		=   Y1_obj - Y1_tip;
Dt2		=   Y2_obj - Y2_tip;
dDt1	=   dY1_obj - dY1_tip;
dDt2	=   dY2_obj - dY2_tip;

% 把持力(Grasping force)
Kr1		=	225000;
Kr2		=	225000;
Krv1	=	500 * sqrt(abs(2 * r1 * Dr1 - Dr1^2));
Krv2	=	500 * sqrt(abs(2 * r2 * Dr2 - Dr2^2));
% 
% Kt1		=	10000000 * sqrt(abs(2 * r1 * Dr1 - Dr1^2));
% Kt2		=	10000000 * sqrt(abs(2 * r2 * Dr2 - Dr2^2));
Kt1		=	200000 * sqrt(abs(2 * r1 * Dr1 - Dr1^2));
Kt2		=	200000 * sqrt(abs(2 * r2 * Dr2 - Dr2^2));
Ktv1	=	200 * sqrt(abs(2 * r1 * Dr1 - Dr1^2));
Ktv2	=	200 * sqrt(abs(2 * r2 * Dr2 - Dr2^2));

% 目標力 [N]
f_d		=	2.0;

force	=	[Kr1 * Dr1^2 - Krv1 * dDr1; Kr2 * Dr2^2 - Krv2 * dDr2; f_d];

if(force(1) < 0)
	force(1) = 0;
end
if(force(2) < 0)
	force(2) = 0;
end

lambda	=	[Kt1 * Dt1 * abs(Dt1) + Ktv1 * dDt1; Kt2 * Dt2 * abs(Dt2) + Ktv2 * dDt2; 0.0];

if(Dr1 <= 0)
	lambda(1) = 0;
end
if(Dr2 <= 0)
	lambda(2) = 0;
end

%%%%%%%%%%%%%%% 微分式 =Differential= %%%%%%%%%%%%%%%
% % 接触点速度(dxi,dyi)
% dx1		=	[dx01(1) - r1 * sin(o(3)) * do(3);
% 			 dx01(2) - r1 * cos(o(3)) * do(3)];
% 
% dx2		=	[dx02(1) + r2 * sin(o(3)) * do(3);
% 			 dx02(2) + r2 * cos(o(3)) * do(3)];
% 
% % (Y1,Y2)
% dY1_tip	=	r1 * ( - do(3) + dq1(1) + dq1(2) + dq1(3));
% dY2_tip	=	r2 * (   do(3) + dq2(1) + dq2(2) + dq2(3));
% 
% dY1_obj	=	(dx1(1,1) - do(1)) * sin(o(3)) + (x1(1,1) - o(1)) * cos(o(3)) * do(3) + (dx1(2,1) - do(2)) * cos(o(3)) - (x1(2,1) - o(2)) * sin(o(3)) * do(3);
% dY2_obj	=	(dx2(1,1) - do(1)) * sin(o(3)) + (x2(1,1) - o(1)) * cos(o(3)) * do(3) + (dx2(2,1) - do(2)) * cos(o(3)) - (x2(2,1) - o(2)) * sin(o(3)) * do(3);
% 
% % dot(Y1+Y2)
% aY_tip	=	dY1_tip + dY2_tip;
% aY_obj	=	dY1_obj + dY2_obj;

%%%%%%%%%%%%%%% ヤコビ行列 =Position= %%%%%%%%%%%%%%%
% ∂Dr/∂q
Dr1_q1		=	  rx' * J01;
Dr2_q2		=	- rx' * J02;

% ∂Dr/∂z
Dr1_x		=	[- rx',   Y1_obj];
Dr2_x		=	[  rx', - Y2_obj];

% ∂Dt/∂q
Dt1_q1		=	  r1 * ones(1,2) + ry' * J01;
Dt2_q2		=	- r2 * ones(1,2) + ry' * J02;

% ∂Dt/∂z
Dt1_x		=	[- ry',   O_side / 2 - Dr1];
Dt2_x		=	[- ry', - O_side / 2 + Dr2];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 全システム慣性行列 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M			=	blkdiag(H1, H2, Ho);

%%%%%%%%%%%%%%% Control Law %%%%%%%%%%%%%%%
% Control input
% GP1			= - J01' * (x01 - x02) * f_d / (r1 + r2);
% GP2			=   J02' * (x01 - x02) * f_d / (r1 + r2);
GP1			= - J01' * (x01 - x02) * f_d / norm(x01 - x02);
GP2			=   J02' * (x01 - x02) * f_d / norm(x01 - x02);

%----- 姿勢制御 -----%
Jp1			=	[  x02(2) - x01(2), - x02(1) + x01(1)] / norm(x02 - x01); 
Jp2			=	[- x02(2) + x01(2),   x02(1) - x01(1)] / norm(x02 - x01); 
theta		=	atan2(x02(2) - x01(2), x02(1) - x01(1));
% theta		=	o(3);
dtheta		=	Jp1 * J01 * dq1 + Jp2 * J02 * dq2;

Kp			=	1.0 * 4.0;
Kpv			=	1.0 * 0.15;
Kpi			=	1.0 * 0.0;

if(time <= 3.0)
	theta_d		=	0.0 / 180.0 * pi;
% elseif(time > 2.0 && time <= 4.0)
% 	theta_d		=	-10.0 / 180.0 * pi;
% elseif(time > 4.0 && time <= 6.0)
% 	theta_d		=	10.0 / 180.0 * pi;
% elseif(time > 6.0 && time <= 8.0)
% 	theta_d		=	-10.0 / 180.0 * pi;
else
	theta_d		=	5.0 / 180.0 * pi;
end

Dp			=	theta - theta_d;

up1			=	- J01' * (Jp1' * (Kp * Dp + Kpv * dtheta + Kpi * s_Dp));
up2			=	- J02' * (Jp2' * (Kp * Dp + Kpv * dtheta + Kpi * s_Dp));

%----- 位置制御 -----%
Kx		=	diag([120.0, 300.0]);
Kxv		=	diag([0.3, 0.3]);
Kxi		=	diag([0.0, 0.0]);

x_cp	=	(x01 + x02) / 2.0;
dx_cp	=	(dx01 + dx02) / 2.0;
% x_cp	=	o(1:2);
% dx_cp	=	do(1:2);

if(time <= 3.0)
	x_d		=	[0.05; 0.08];
% elseif(time > 2.0 && time <= 4.0)
% 	x_d		=	[0.04; 0.08];
% elseif(time > 4.0 && time <= 6.0)
% 	x_d		=	[0.04; 0.07];
% elseif(time > 6.0 && time <= 8.0)
% 	x_d		=	[0.02; 0.07];
else
	x_d		=	[0.07; 0.10];
end

Dx	=	(x_cp - x_d);

ux1		=	- J01' * (Kx * Dx + Kxv * dx_cp + Kxi * s_Dx); 
ux2		=	- J02' * (Kx * Dx + Kxv * dx_cp + Kxi * s_Dx); 

C1			=	diag([0.04, 0.04]);
C2			=	diag([0.04, 0.04]);

tau1		=	GP1 + up1 + ux1 - C1 * dq1;
tau2		=	GP2 + up2 + ux2 - C2 * dq2;
% tau1		=	GP1 - C1 * dq1;
% tau2		=	GP2 - C2 * dq2;

%%%%%%%%%%%%%%% Vector "K" %%%%%%%%%%%%%%%
% 指ロボット
K_1			=	tau1 - S1 - G1 - Dr1_q1' * force(1) - Dt1_q1' * lambda(1);
K_2			=	tau2 - S2 - G2 - Dr2_q2' * force(2) - Dt2_q2' * lambda(2);
% 物体
K_O			=	[0.0; OM * g; 0.0] - Dr1_x' * force(1) - Dr2_x' * force(2) - Dt1_x' * lambda(1) - Dt2_x' * lambda(2);
% K			=	[K_1', K_2', K_O']';

%%%%%%%%%%%%%%% Output %%%%%%%%%%%%%%%
% 加速度計算
% dda         =	M \ K;

% Matrix dda ⇒ 変数
% ddq1		=   dda(1:3);
% ddq2		=   dda(4:6);
% ddo			=   dda(7:9);
ddq1		=   H1 \ K_1;
ddq2		=   H2 \ K_2;
ddo			=   Ho \ K_O;

% [mm]：単位へ,[deg]：単位へ
Y			=	[1000 * (Y1_obj - Y2_obj); 0.0];
posture		=	180.0 / pi * [o(3); theta_d];

% Main Output
OUT			=	[ddq1' ddq2' ddo' dq1' dq2' do' x1' x2' Y' posture' force' lambda' x_cp' x_d' Dp Dx'];
