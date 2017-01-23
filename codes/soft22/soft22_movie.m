%figure('Name', 'The simulation of pinching', 'NumberTitle', 'off');%,  'Position',[250 150 800 800]);
figure(1);
	set(1, 'Name', 'The simulation of pinching', 'NumberTitle', 'off', 'Position', [800 100 1000 1000]);

	q = 0: (2 * pi) / 100: 2 * pi;
	r = 0.015;
	finger1circle_x = r * cos(q);
	finger1circle_y = r * sin(q);
	finger2circle_x = r * cos(q);
	finger2circle_y = r * sin(q);

for k=1: size(position, 1);
%%%%%%%%%% 第1指(左) %%%%%%%%%%
% 第2リンク
	plot(position(k, [3,7]), position(k, [4,8]), '-k', 'Linewidth', 4, 'MarkerFaceColor', 'y', 'MarkerSize', 8);
	hold on;
% 第1リンク
	plot(position(k, [1,3]), position(k, [2,4]), '-ok', 'Linewidth', 4, 'MarkerFaceColor', 'y', 'MarkerSize', 8);

% 指先
	x1 = finger1circle_x + position(k, 5);
	y1 = finger1circle_y + position(k, 6);
	plot(x1, y1, 'Color', [1.000 0.500 0.500], 'Linewidth', 2.5);

% 指先接触点
%	plot(position(k, 101), position(k, 102), 'o', 'Linewidth', 0.5, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'c', 'MarkerSize', 5);

%%%%%%%%%% 第2指(右) %%%%%%%%%%
% 第2リンク
	plot(position(k, [11,15]), position(k, [12,16]), '-k', 'Linewidth', 4, 'MarkerFaceColor', 'y', 'MarkerSize', 8);
% 第1リンク
	plot(position(k, [9,11]), position(k, [10,12]), '-ok', 'Linewidth', 4, 'MarkerFaceColor', 'y', 'MarkerSize', 8);

% 指先(球)
	x2 = finger2circle_x + position(k, 13);
	y2 = finger2circle_y + position(k, 14);
	plot(x2, y2, 'Color', [1.000 0.500 0.500], 'Linewidth', 2.5);

% 指先接触点
%	plot(position(k, 103), position(k, 104), 'o', 'Linewidth', 0.5, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'c', 'MarkerSize', 5);

%%%%%%%%%% 対象物 %%%%%%%%%%
% 対象物四隅
	plot(position(k, [17,19]), position(k, [18,20]), 'Color', [0.000 0.500 0.500], 'Linewidth', 2.5);
	plot(position(k, [19,21]), position(k, [20,22]), 'Color', [0.000 0.500 0.500], 'Linewidth', 2.5);
	plot(position(k, [21,23]), position(k, [22,24]), 'Color', [0.000 0.500 0.500], 'Linewidth', 2.5);
	plot(position(k, [23,17]), position(k, [24,18]), 'Color', [0.000 0.500 0.500], 'Linewidth', 2.5);

% 対象物質量中心
	plot(position(k, 29), position(k, 30), 'or', 'Linewidth', 0.5, 'MarkerFaceColor', 'r', 'MarkerSize', 5);

%	set(gca,'FontWeight', 'normal', 'FontSize', 20, 'FontName', 'times', 'xtick', [-0.1 -0.05 0.0 0.05 0.1], 'ytick', [-0.1 -0.05 0.0 0.05 0.1], 'YDir', 'reverse');
% 	set(gca,'FontWeight', 'normal', 'FontSize', 14, 'FontName', 'times', 'xtick', [-0.04 -0.02 0.0 0.02 0.04 0.06 0.08 0.1], 'YDir', 'reverse');
	set(gca,'FontWeight', 'normal', 'FontSize', 14, 'FontName', 'times', 'xtick', [-0.05 0.0 0.05 0.1 0.15], 'ytick', [-0.05 0.0 0.05 0.1 0.15], 'YDir', 'reverse');
% 	set(gca,'FontWeight', 'normal', 'FontSize', 14, 'FontName', 'times', 'xtick', [-0.04 -0.02 0.0 0.02 0.04 0.06 0.08 0.1]);

	hold off;
	xlabel('{\itx}-position [m]');
	ylabel('{\ity}-position [m]');
% 	axis([-0.040,0.100,-0.020,0.120]);
	axis([-0.050,0.150,-0.030,0.170]);
%	axis([-0.025,0.065,-0.01,0.08]);
	axis square;
	grid on;

% 時間表示
%	text(-0.038, 0.125, ['\fontname{times}\fontsize{14}Time = ', num2str(position(k, 114), '%5.3f'), '[sec]']);
% 	text(-0.038, 0.115, ['\fontname{times}\fontsize{14}Time = ', num2str(position(k, 114), '%2.1f'), '[sec]']);

%	M(k) = getframe;
	M(k) = getframe(1);
end;



%%%%%%%%%% 初期姿勢描画 %%%%%%%%%%
	hold on;
%%%%%%%%%% 第1指(左) %%%%%%%%%%
% 第2リンク
	plot(position(1, [3,7]), position(1, [4,8]), '-k', 'Linewidth', 0.5, 'MarkerFaceColor', 'y', 'MarkerSize', 6);
% 第1リンク
	plot(position(1, [1,3]), position(1, [2,4]), '-ok', 'Linewidth', 0.5, 'MarkerFaceColor', 'y', 'MarkerSize', 6);

% 指先
	x1 = finger1circle_x + position(1, 5);
	y1 = finger1circle_y + position(1, 6);
	plot(x1, y1, 'Color', [1.000 0.500 0.500], 'Linewidth', 0.5);

% 指先接触点
%	plot(position(1, 101), position(1, 102), 'o', 'Linewidth', 0.5, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'c', 'MarkerSize', 5);

%%%%%%%%%% 第2指(右) %%%%%%%%%%
% 第2リンク
	plot(position(1, [11,15]), position(1, [12,16]), '-k', 'Linewidth', 0.5, 'MarkerFaceColor', 'y', 'MarkerSize', 6);
% 第1リンク
	plot(position(1, [9,11]), position(1, [10,12]), '-ok', 'Linewidth', 0.5, 'MarkerFaceColor', 'y', 'MarkerSize', 6);

% 指先(球)
	x2 = finger2circle_x + position(1, 13);
	y2 = finger2circle_y + position(1, 14);
	plot(x2, y2, 'Color', [1.000 0.500 0.500], 'Linewidth', 0.5);

% 指先接触点
%	plot(position(1, 103), position(1, 104), 'o', 'Linewidth', 0.5, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'c', 'MarkerSize', 5);

%%%%%%%%%% 対象物 %%%%%%%%%%
% 対象物四隅
	plot(position(1, [17,19]), position(1, [18,20]), 'Color', [0.000 0.500 0.500], 'Linewidth', 0.5);
	plot(position(1, [19,21]), position(1, [20,22]), 'Color', [0.000 0.500 0.500], 'Linewidth', 0.5);
	plot(position(1, [21,23]), position(1, [22,24]), 'Color', [0.000 0.500 0.500], 'Linewidth', 0.5);
	plot(position(1, [23,17]), position(1, [24,18]), 'Color', [0.000 0.500 0.500], 'Linewidth', 0.5);

% 対象物質量中心
	plot(position(1, 33), position(1, 34), 'or', 'Linewidth', 0.5, 'MarkerFaceColor', 'r', 'MarkerSize', 5);


%%%%%%%%%% 最終姿勢描画 %%%%%%%%%%
	hold on;
%%%%%%%%%% 第1指(左) %%%%%%%%%%
% 第2リンク
	plot(position(k, [3,7]), position(k, [4,8]), '-k', 'Linewidth', 4, 'MarkerFaceColor', 'y', 'MarkerSize', 8);
% 第1リンク
	plot(position(k, [1,3]), position(k, [2,4]), '-ok', 'Linewidth', 4, 'MarkerFaceColor', 'y', 'MarkerSize', 8);

% 指先
	x1 = finger1circle_x + position(k, 5);
	y1 = finger1circle_y + position(k, 6);
	plot(x1, y1, 'Color', [1.000 0.500 0.500], 'Linewidth', 2.5);

% 指先接触点
%	plot(position(k, 101), position(k, 102), 'o', 'Linewidth', 0.5, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'c', 'MarkerSize', 5);

%%%%%%%%%% 第2指(右) %%%%%%%%%%
% 第2リンク
	plot(position(k, [11,15]), position(k, [12,16]), '-k', 'Linewidth', 4, 'MarkerFaceColor', 'y', 'MarkerSize', 8);
% 第1リンク
	plot(position(k, [9,11]), position(k, [10,12]), '-ok', 'Linewidth', 4, 'MarkerFaceColor', 'y', 'MarkerSize', 8);

% 指先(球)
	x2 = finger2circle_x + position(k, 13);
	y2 = finger2circle_y + position(k, 14);
	plot(x2, y2, 'Color', [1.000 0.500 0.500], 'Linewidth', 2.5);

% 指先接触点
%	plot(position(k, 103), position(k, 104), 'o', 'Linewidth', 0.5, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'c', 'MarkerSize', 5);

%%%%%%%%%% 対象物 %%%%%%%%%%
% 対象物四隅
	plot(position(k, [17,19]), position(k, [18,20]), 'Color', [0.000 0.500 0.500], 'Linewidth', 1.5);
	plot(position(k, [19,21]), position(k, [20,22]), 'Color', [0.000 0.500 0.500], 'Linewidth', 1.5);
	plot(position(k, [21,23]), position(k, [22,24]), 'Color', [0.000 0.500 0.500], 'Linewidth', 1.5);
	plot(position(k, [23,17]), position(k, [24,18]), 'Color', [0.000 0.500 0.500], 'Linewidth', 1.5);

% 対象物質量中心
	plot(position(1, 29), position(1, 30), 'or', 'Linewidth', 0.5, 'MarkerFaceColor', 'r', 'MarkerSize', 5);

%	text(0.035, -0.015, '\fontname{times}\fontsize{14}{\it\theta_d} = 5.0 [deg]')
