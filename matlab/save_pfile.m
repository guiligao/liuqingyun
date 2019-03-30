function  save_pfile(inputPath,savePath)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
d = dir(inputPath);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
mfileName = dir([inputPath,'\*.m']);
pcode(inputPath,'-inplace');% pcode(SaveFolderName,'-inplace')
%% 产生目标文件夹
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

%% 移动生成的p文件
for i=1:length(mfileName)
    mFileName  = mfileName(i).name;
    disp(['m文件路径：', mfileName(i).folder,'\',mFileName])
    mFileName(length(mFileName)) = 'p';
    pFileInputPath = [mfileName(i).folder,'\',mFileName];
    pFileSavePath = [savePath,'\',mFileName];
    disp(['p文件路径：',pFileSavePath])
    movefile(pFileInputPath, pFileSavePath)
end

%% 递归
for i=1:length(nameFolds)
    subSavePath = strcat(savePath,'\',nameFolds{i});
    subInputPath = strcat(inputPath,'\',nameFolds{i});
    save_pfile(subInputPath, subSavePath);
end
end