function deleteFile(path,mode)
% mode 1 ֱ�ӷ���
% mode 2 �h��m�ļ�
% mode 3 �h��p�ļ�
% mode 4 �h��p�ļ���m�ļ�
% mode 5 �h�������ļ����ļ���
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
            disp(['exception��    Ŀ��·��Ϊ:',path,' ��ǰ·��Ϊ:',local])
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

