clear
 files = dir('*.mat');
%A_C_X = cell(size(files));
for i=1:length(files)
  value = getfield(files(i), 'name');
  load(value);
  A_C_X{i} = a_c_x;
  A_C_Y{i} = a_c_y;
  C_L_X{i} = c_l_x;
  C_L_Y{i} = c_l_y;
  L_P_X{i} = l_p_x;
  L_P_Y{i} = l_p_y;
end

for i=7:15
subplot(2,3,1);
plot(1:length(L_P_X{i}),L_P_X{i});
title('Lineal path function in x')
hold on;
subplot(2,3,2);
plot(1:length(L_P_Y{i}),L_P_Y{i});
title('Lineal path function in y')
hold on;
subplot(2,3,3);
plot(1:length(C_L_X{i}),C_L_X{i});
NumTicks = 11;
L = get(gca,'XLim');
set(gca,'XTick',linspace(L(1),L(2),NumTicks))
title('Chord length function in x');
hold on;
subplot(2,3,4)
plot(1:length(C_L_Y{i}),C_L_Y{i});
NumTicks = 11;
L = get(gca,'XLim');
set(gca,'XTick',linspace(L(1),L(2),NumTicks))
title('Chord length function in y');
hold on;
subplot(2,3,5)
plot(0:length(A_C_X{i})-1,A_C_X{i});
title('Auto correlation w.r.t. distance in x');
hold on;
subplot(2,3,6)
plot(0:length(A_C_Y{i})-1,A_C_Y{i});
title('Auto correlation w.r.t. distance in y');
hold on;
end