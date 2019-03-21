function w_smooth = smoothGT(w,segma)


boundaryCondition = 'periodical';
if strcmp(boundaryCondition,'periodical')
    bounMargin = 3;
    w_temp = [w(end-bounMargin+1:end,:);w;w(1:bounMargin,:)];
    w_period = [w_temp(:,end-bounMargin+1:end),w_temp,w_temp(:,1:bounMargin)];
    w_smooth = smoothImg(w_period,segma);
    w_smooth = w_smooth(bounMargin+1:end-bounMargin, bounMargin+1:end-bounMargin);
else
    w_smooth = smoothImg(w,segma);
end