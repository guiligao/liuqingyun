function  save_pfile(inputPath,savePath)
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
d = dir(inputPath);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
mfileName = dir([inputPath,'\*.m']);
pcode(inputPath,'-inplace');% pcode(SaveFolderName,'-inplace')
%% ����Ŀ���ļ���
local = pwd;
pathCell = strsplit(savePath,{'\','/'});
for i=1:length(pathCell)
    if i == 1
        toPath = [pathCell{i},'\'];
    else
        toPath = pathCell{i};
    end
    
    if exist(toPath,'dir')==0
        mkdir(toPath);
    end
    cd(toPath)
end
cd(local)

%% �ƶ����ɵ�p�ļ�
for i=1:length(mfileName)
    mFileName  = mfileName(i).name;
    disp(['m�ļ�·����', mfileName(i).folder,'\',mFileName])
    mFileName(length(mFileName)) = 'p';
    pFileInputPath = [mfileName(i).folder,'\',mFileName];
    pFileSavePath = [savePath,'\',mFileName];
    disp(['p�ļ�·����',pFileSavePath])
    movefile(pFileInputPath, pFileSavePath)
end

%% �ݹ�
for i=1:length(nameFolds)
    subSavePath = strcat(savePath,'\',nameFolds{i});
    subInputPath = strcat(inputPath,'\',nameFolds{i});
    save_pfile(subInputPath, subSavePath);
end
end