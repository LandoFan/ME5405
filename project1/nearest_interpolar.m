% 清空之前的图形
clf;

% 定义井字形线段的坐标
x_lines = [-1 1; -1 1; -0.5 -0.5; 0.5 0.5];
y_lines = [-0.5 -0.5; 0.5 0.5; -1 1; -1 1];

% 绘制井字形线段
figure(1);
subplot(1,2,1)
hold on;

% 分别绘制每一条线段
for i = 1:size(x_lines, 1)
    plot(x_lines(i, :), y_lines(i, :), 'k-', 'LineWidth', 2);
end

% 在交点处标以蓝色圆点
scatter(0.5, 0.5, 100, 'ro', 'filled');
scatter(-0.5, 0.5, 100, 'ro', 'filled');
scatter(0.5, -0.5, 100, 'ro', 'filled');
scatter(-0.5, -0.5, 100, 'ro', 'filled');

% 在4个原点处标注Q1，Q2，Q3，Q4
text(0.7, 0.7, 'Q1', 'FontSize', 10, 'HorizontalAlignment', 'right');
text(-0.7, 0.7, 'Q2', 'FontSize', 10, 'HorizontalAlignment', 'left');
text(0.7, -0.7, 'Q3', 'FontSize', 10, 'VerticalAlignment', 'bottom');
text(-0.7, -0.6, 'Q4', 'FontSize', 10, 'VerticalAlignment', 'top');

% 在口内临近Q1的地方绘制一个绿色圆点
scatter(-0.2, 0.2, 100, 'go', 'filled');
text(-0.15, 0.15, 'P', 'FontSize', 10, 'VerticalAlignment', 'top');
% 定义起始点和结束点的坐标
start_point = [-0.2, 0.2];
end_point = [-0.5, 0.5];

% 绘制虚线
plot([start_point(1), end_point(1)], [start_point(2), end_point(2)], 'b--', 'LineWidth', 2);

% 设置坐标轴范围
axis([-2 2 -2 2]);
% 关闭绘图保持
set(gca,'XTick',[]) % 隐藏X轴刻度
set(gca,'YTick',[]) % 隐藏Y轴刻度
set(gca, 'XColor', 'none'); % 隐藏X轴线
set(gca, 'YColor', 'none'); % 隐藏Y轴线
hold off;


subplot(1,2,2)
hold on;

% 分别绘制每一条线段
for i = 1:size(x_lines, 1)
    plot(x_lines(i, :), y_lines(i, :), 'k-', 'LineWidth', 2);
end

% 在交点处标以蓝色圆点
scatter(0.5, 0.5, 100, 'ro', 'filled');
scatter(-0.5, 0.5, 100, 'ro', 'filled');
scatter(0.5, -0.5, 100, 'ro', 'filled');
scatter(-0.5, -0.5, 100, 'ro', 'filled');

% 在4个原点处标注Q1，Q2，Q3，Q4
text(0.7, 0.7, 'Q1', 'FontSize', 10, 'HorizontalAlignment', 'right');
text(-0.7, 0.7, 'Q2', 'FontSize', 10, 'HorizontalAlignment', 'left');
text(0.7, -0.7, 'Q3', 'FontSize', 10, 'VerticalAlignment', 'bottom');
text(-0.7, -0.6, 'Q4', 'FontSize', 10, 'VerticalAlignment', 'top');

% 在口内临近Q1的地方绘制一个绿色圆点
scatter(-0.2, 0.2, 100, 'go', 'filled');
text(-0.15, 0.15, 'P', 'FontSize', 10, 'VerticalAlignment', 'top');
% 定义起始点和结束点的坐标
start_point = [-0.2, 0.2];
end_point = [-0.2, 0.5];

% 绘制虚线
plot([start_point(1), end_point(1)], [start_point(2), end_point(2)], 'b--', 'LineWidth', 2);

% 定义起始点和结束点的坐标
start_point = [-0.5, 0.2];
end_point = [-0.2, 0.2];

% 绘制虚线
plot([start_point(1), end_point(1)], [start_point(2), end_point(2)], 'b--', 'LineWidth', 2);
text(-0.3, 0.7, 'a', 'FontSize', 10, 'VerticalAlignment', 'top');
text(-0.6, 0.3, 'b', 'FontSize', 10, 'HorizontalAlignment', 'left');
% 设置坐标轴范围
axis([-2 2 -2 2]);
% 关闭绘图保持
set(gca,'XTick',[]) % 隐藏X轴刻度
set(gca,'YTick',[]) % 隐藏Y轴刻度
set(gca, 'XColor', 'none'); % 隐藏X轴线
set(gca, 'YColor', 'none'); % 隐藏Y轴线

hold off;

saveas(gcf, 'all interpolar.png');
