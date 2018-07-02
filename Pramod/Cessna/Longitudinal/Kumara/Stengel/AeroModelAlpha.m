	function [CD,CL,CY,Cl,Cm,Cn,Thrust]	=	AeroModelAlpha(x,u,Mach,alphar,betar,V)
%	FLIGHT Aerodynamic Coefficients of the Aircraft, Thrust Model,
%	and Geometric and Inertial Properties

%   BizJet B
%   ========
%	June 12, 2015
%	===============================================================
%	Copyright 2006-2015 by ROBERT F. STENGEL.  All rights reserved.

%	High-Angle-of-Attack, Mach-Independent Model
%	Landing Gear: Up (GEAR = 0)
%	Flap Setting, u(6): 0 deg
%	Symmetric Spoiler: Closed (SPOIL = 0)

	global b cBar SMI

%	Inertial, Geometric, and Aerodynamic Properties
%   *** GeoMassAero.m must first be run to save InerGeo.mat, DataTable.mat, 
%   and RotCont.mat ***

	load InerGeo.mat
    load DataTable.mat
    load RotCont.mat

	alphadeg	=	57.2957795 * alphar;

%	Thrust Properties
	StaticThrust	=	2*6.49*10^3;	% Static Thrust @ Sea Level, N	
%	Current Thrust
	[airDens,airPres,temp,soundSpeed] = Atmos(-x(6));
	Thrust			=	u(4) * StaticThrust * (airDens / 1.225)^0.7 ...
						* (1 - exp((-x(6) - 17000) / 2000));
									% Thrust at Altitude, N
	
%	Current Longitudinal Characteristics
%	====================================

%	Lift Coefficient
	CLStatic    =	interp1(AlphaTable,CLTable,alphadeg);
									% Static Lift Coefficient
	CLqr        =	CLqHat * cBar/(2*V);
									% Pitch-Rate Effect, per rad/s
	CLdEr   	=	interp1(AlphaTable,CLdETable,alphadeg);
                                    % Elevator Effect, per rad
	CLdSr       =	CLdEr;			% Stabilator Effect, per rad
    CL          =	CLStatic + CLqr*x(8) + CLdSr*u(7) + CLdEr*u(1);
									% Total Lift Coefficient	
%	Drag Coefficient
	CDStatic	=	interp1(AlphaTable,CDTable,alphadeg);
									% Static Drag Coefficient
	CD          =	CDStatic;		% Total Drag Coefficient
	
%	Pitching Moment Coefficient
	CmStatic	=	interp1(AlphaTable,CmTable,alphadeg);
									% Static Pitching Moment Coefficient
	CmdEr		=	interp1(AlphaTable,CmdETable,alphadeg);
									% Elevator Effect, per rad
	Cmqr        =	-CLqHat*(lHT/cBar) * cBar/(2*V);
									% Pitch-Rate + Alpha-Rate Effect, per rad/s
    CmdSr       =	CmdEr;          % Stabilator Effect, per rad
	Cm          =	CmStatic - CL*SMI + Cmqr*x(8) + CmdSr*u(7) + CmdEr*u(1);
									% Total Pitching Moment Coefficient
	
%	Current Lateral-Directional Characteristics
%	===========================================

%	Rolling Moment Coefficient
	ClBr	=	interp1(AlphaTable,ClBetaTable,alphadeg);
									% Dihedral Effect, per rad
	ClpHat	=	interp1(AlphaTable,ClpHatTable,alphadeg);
    Clpr    =   ClpHat * (b / (2 * V));				
	ClrHat	=	interp1(AlphaTable,ClrHatTable,alphadeg);
									% Roll-Rate Effect, per rad/s	
	Clrr	=	ClrHat * (b / (2 * V));				
									% Yaw-Rate Effect, per rad/s
	CldAr	=	interp1(AlphaTable,CldATable,alphadeg);
									% Aileron Effect, per rad	
	CldRr	=	interp1(AlphaTable,CldRTable,alphadeg);
									% Rudder Effect, per rad
	CldASr	=	0;                  % Asymmetric Spoiler Effect, per rad
	Cl      =	(ClBr*betar + CldRr*u(3)) + Clrr * x(9) + Clpr * x(7) ...
                + (CldAr*u(2) + CldASr*u(5));
									% Total Rolling-Moment Coefficient
                                    
%	Side-Force Coefficient
	CYBr	=	interp1(AlphaTable,CYBetaTable,alphadeg);
									% Side-Force Slope, per rad
	CYdAr	=	CYdAo;              % Aileron Effect, per rad	
	CYdRr	=	0.1574;				% Rudder Effect, per rad	
	CYdASr	=	0;                  % Asymmetric Spoiler Effect, per rad
	CY	=	(CYBr*betar + CYdRr*u(3)) + (CYdAr*u(2) + CYdASr*u(5));
									% Total Side-Force Coefficient
                                    
%	Yawing Moment Coefficient
	CnBr	=	interp1(AlphaTable,CnBetaTable,alphadeg);
									% Directional Stability, per rad
	Cnpr	=	CL * (1 + 3 * taperw)/(12 * (1 + taperw)) * (b / (2 * V));				
									% Roll-Rate Effect, per rad/s	
	Cnrr	=	(-2 * (lVT / b) * CnBr - 0.1 * CL^2) * (b / (2 * V));
    CnpHat	=	interp1(AlphaTable,CnpHatTable,alphadeg);
    Cnpr    =   CnpHat * (b / (2 * V));				
	CnrHat	=	interp1(AlphaTable,CnrHatTable,alphadeg);
									% Roll-Rate Effect, per rad/s	
	Cnrr	=	CnrHat * (b / (2 * V));				
									% Yaw-Rate Effect, per rad/s
									% Yaw-Rate Effect, per rad/s
	CndAr	=	interp1(AlphaTable,CndATable,alphadeg);
									% Aileron Effect, per rad	
	CndRr	=	interp1(AlphaTable,CndRTable,alphadeg);
									% Rudder Effect, per rad	
	CndASr	=	0;			% Asymmetric Spoiler Effect, per rad
	Cn	=	(CnBr*betar + CndRr*u(3)) + Cnrr * x(9) + Cnpr * x(7) ...
			+ (CndAr*u(2) + CndASr*u(5));
									% Total Yawing-Moment Coefficient

