function deleteFile(path,mode)
% mode 1 直接返回
% mode 2 刪除m文件
% mode 3 刪除p文件
% mode 4 刪除p文件和m文件
% mode 5 刪除所有文件和文件夹
switch mode
    case 2
        if  strcmp(path(length(path)),'\')==1
            delete([path,'*.m']);
        else
            delete([path,'\*.m']);
        end
    case 3
       if  strcmp(path(length(path)),'\')==1
            delete([path,'*.p']);
        else
            delete([path,'\*.p']);
        end
    case 4
        if  strcmp(path(length(path)),'\')==1
            delete([path,'*.p']);
            delete([path,'*.m']);
        else
            delete([path,'\*.p']);
             delete([path,'\*.m']);
        end
    case 5
        tmp = pwd;
        cd(path)
        local = pwd;
        if strcmp(path,local)~=1
            disp(['exception：    目标路径为:',path,' 当前路径为:',local])
            exit
        end
        delete('*.*')
        d = dir(path);
        isub = [d(:).isdir];
        nameFolds = {d(isub).name}';
        nameFolds(ismember(nameFolds,{'.','..'})) = [];
        for i=1:length(nameFolds)
            rmdir(nameFolds{i},'s')
        end
        cd(tmp)
    otherwise
        return;
end

d = dir(path);
isub = [d(:).isdir];
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];

for i = 1:length(nameFolds)
    if  strcmp(path(length(path)),'\')==1
        deleteFile([path,nameFolds{i}],mode)
    else
        deleteFile([path,'\',nameFolds{i}],mode)
    end
end





end

