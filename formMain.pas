{
******************************************************
  Telltale Music Extractor
  Copyright (c) 2006 - 2011 Bgbennyboy
  Http://quick.mixnmojo.com
******************************************************
}
{
  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation; either version 2
  of the License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
}

unit formMain;

interface

uses
  Windows, Messages, SysUtils, Forms, Classes, Controls, StdCtrls, ImgList,
  ExtCtrls, ComCtrls, XPMan, Menus, Dialogs,
  AdvMenus, AdvMenuStylers, AdvEdBtn, AdvDirectoryEdit, AdvEdit, HTMLabel,
  JvBaseDlg, JvBrowseFolder, JvExControls, JvSpeedButton, JCLSysInfo, JCLFileUtils,
  PngImageList, ACS_Misc,
  uTelltaleFuncs, uTtarchBundleManager, uTelltaleTypes, uTelltaleMemStream, uSoundTrackManager;

type
  TMusicType = (
    mtOGG,
    mtTTARCH,
    mtNONE
  );

  TfrmMain = class(TForm)
    DirEditDest: TAdvDirectoryEdit;
    btnGo: TButton;
    ProgressBar1: TProgressBar;
    XPManifest1: TXPManifest;
    HTMLabel1: THTMLabel;
    HTMLabel2: THTMLabel;
    btnOpen: TJvSpeedButton;
    EditPath: TLabeledEdit;
    dlgBrowseForFolder: TJvBrowseForFolderDialog;
    PngImageList1: TPngImageList;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    AdvPopupMenuOpen: TAdvPopupMenu;
    MenuItemOpenFolder: TMenuItem;
    N2: TMenuItem;
    Bone1: TMenuItem;
    MenuItemOpenBone1: TMenuItem;
    MenuItemOpenBone2: TMenuItem;
    CrimeSceneInvestigation1: TMenuItem;
    MenuItemOpenCSI: TMenuItem;
    MenuItemOpenCSIHardEvidence: TMenuItem;
    SamAndMaxSeason11: TMenuItem;
    MenuItemOpenCultureShock: TMenuItem;
    MenuItemOpenSituationComedy: TMenuItem;
    MenuItemOpenMoleMobMeatball: TMenuItem;
    MenuItemOpenAbeLincoln: TMenuItem;
    MenuItemOpenReality20: TMenuItem;
    MenuItemOpenBrightSideOfTheMoon: TMenuItem;
    SamAndMaxSeason21: TMenuItem;
    MenuItemOpenIceStationSanta: TMenuItem;
    MenuItemOpenMoaiBetterBlues: TMenuItem;
    MenuItemOpenNightOfTheRavingDead: TMenuItem;
    MenuItemOpenChariotsoftheDogs: TMenuItem;
    MenuItemOpenWhatsNewBeelzebub: TMenuItem;
    StrongBadSeason11: TMenuItem;
    MenuItemOpenStrongBadEP1: TMenuItem;
    MenuItemOpenStrongBadEP2: TMenuItem;
    MenuItemOpenStrongBadEP3: TMenuItem;
    MenuItemOpenStrongBadEP4: TMenuItem;
    MenuItemOpenStrongBadEP5: TMenuItem;
    MenuItemOpenTexas: TMenuItem;
    WallaceandGromitsGrandAdventures1: TMenuItem;
    MenuItemOpenWallaceEP4: TMenuItem;
    MenuItemOpenWallaceEP3: TMenuItem;
    MenuItemOpenWallaceEP2: TMenuItem;
    MenuItemOpenWallaceEP1: TMenuItem;
    TalesOfMonkeyIsland1: TMenuItem;
    MenuItemOpenMonkeyEP1: TMenuItem;
    MenuItemOpenMonkeyEP2: TMenuItem;
    MenuItemOpenMonkeyEP3: TMenuItem;
    MenuItemOpenMonkeyEP4: TMenuItem;
    MenuItemOpenMonkeyEP5: TMenuItem;
    MenuItemOpenCSIDeadlyIntent: TMenuItem;
    TagEditor1: TTagEditor;
    SamAndMaxSeason31: TMenuItem;
    MenuItemOpenSamAndMax305: TMenuItem;
    MenuItemOpenSamAndMax304: TMenuItem;
    MenuItemOpenSamAndMax303: TMenuItem;
    MenuItemOpenSamAndMax302: TMenuItem;
    MenuItemOpenSamAndMax301: TMenuItem;
    PuzzleAgent1: TMenuItem;
    MenuItemOpenPuzzleAgent101: TMenuItem;
    MenuItemOpenCSIFatalConspiracy: TMenuItem;
    MenuItemOpenPokerInventory: TMenuItem;
    BackToTheFuture2: TMenuItem;
    MenuItemOpenBTTF5: TMenuItem;
    MenuItemOpenBTTF4: TMenuItem;
    MenuItemOpenBTTF3: TMenuItem;
    MenuItemOpenBTTF2: TMenuItem;
    MenuItemOpenBTTF1: TMenuItem;
    HectorBadgeOfCarnage1: TMenuItem;
    MenuItemOpenHector101: TMenuItem;
    MenuItemOpenPuzzleAgent102: TMenuItem;
    MenuItemOpenHector102: TMenuItem;
    MenuItemOpenHector103: TMenuItem;
    JurassicParkTheGame: TMenuItem;
    MenuItemOpenJurassicParkEP4: TMenuItem;
    MenuItemOpenJurassicParkEP3: TMenuItem;
    MenuItemOpenJurassicParkEP2: TMenuItem;
    MenuItemOpenJurassicParkEP1: TMenuItem;
    heWalkingDead1: TMenuItem;
    MenuItemOpenWalkingDeadEP1: TMenuItem;
    MenuItemOpenLawAndOrderLegacies: TMenuItem;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OpenPopupMenuHandler(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure MenuItemOpenFolderClick(Sender: TObject);
  private
    fBundle: TTtarchBundleManager;
    fTtarchFileName: string;
    fSourceFiles: TStringList;
    function FindMusicType(Dir: String): TMusicType;
    procedure FindFilesInDirByExt(Path, FileExt: string; FileList: TStrings);
    function CopyFiles: integer;
    function CopyFilesFromTtarch: integer;

    function DoTtarchFiles: integer;
    function DoTtarchFilesWithSoundTrack(SoundTrack: TSoundTrackManager; BundleFileList: TStringList): integer;
    procedure TagMusic(FileName, Title, Album, Artist, Genre, TrackNo, Year, Coverart: string);

    procedure EnableControls(Value: boolean);
    procedure FindMusicTtarchBundles(Dir: string);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

const
  strGameNotFound:    string = 'Couldnt find the game.' + #13 + #13 + 'Try clicking ''Open Folder'' and browse for the game manually.';
  strInvalidFolder:   string = 'Invalid destination folder. Check the destination path';
  strNoMusicFound:    string = 'No .aud or music .ttarch files found! Check the source folder path!';
  strProgName:        string = 'Telltale Music Extractor';
  strProgVersion:     string = '1.4.9.4';
  strProgURL:         string = 'http://quick.mixnmojo.com';
  strTtarchError:     string = 'Error while parsing the Ttarch bundle';
  strSoundTrackDir:   string = 'Soundtracks';
  strCommentTag:      string = 'Created with Telltale Music Extractor ';
  strDumpSoundTrack:  string = 'Do you want to dump this game as a soundtrack?' + #13#13 + 'See the readme for more information about this.';

implementation

{$R *.dfm}

//Find files with a specific extension and add them to a string list
procedure TfrmMain.FindFilesInDirByExt(Path, FileExt: string; FileList: TStrings);
var
  SR: TSearchRec;
begin
  if length(FileExt) > 1 then
    if FileExt[1] <> '.' then
      FileExt:='.' + FileExt;

  if FindFirst(Path + '*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      begin
        if sr.Attr and faDirectory = faDirectory then
        else
        if sr.Attr and faSysFile = faSysFile then
        else
        begin
          if extractfileext(sr.Name)=FileExt then
            filelist.Add(sr.Name);
        end;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

procedure TfrmMain.EnableControls(Value: boolean);
begin
  EditPath.Enabled:=Value;
  DirEditDest.Enabled:=Value;
  btnGo.Enabled:=Value;
end;

function TfrmMain.FindMusicType(Dir: String): TMusicType;
begin
  result:=mtNONE;

  //First see if there's .aud ogg files there
  FindFilesInDirByExt( IncludeTrailingPathDelimiter(EditPath.Text) , '.aud', fSourceFiles);
  if fSourceFiles.Count > 0 then
  begin
    result:=mtOGG;
    exit;
  end;

  //Else see if there's music in a ttarch file in the dir
  FindMusicTtarchBundles( IncludeTrailingPathDelimiter(EditPath.Text) );
  if fTtarchFilename <> '' then
  begin
    result:=mtTTARCH;
    exit;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  //SetDesktopIconFonts(Self.Font);
  fSourceFiles:=TStringList.Create;
  dlgBrowseforfolder.RootDirectory:=fdDesktopDirectory;
  dlgBrowseforfolder.RootDirectoryPath:=GetDesktopDirectoryFolder;
  dirEditDest.Text:=GetDesktopDirectoryFolder;
  //dirEditDest.Enabled:=false;
  //dirEditDest.Enabled:=true;
  DirEditDest.parentfont:=true;
  frmMain.Caption:=strProgName + ' ' + strProgVersion;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  fSourceFiles.Free;
end;

procedure TfrmMain.btnGoClick(Sender: TObject);
var
  MusicType: TMusicType;
  int_CopyCount: integer;
begin
  if DirectoryExists(DirEditDest.Text)=false then
  begin
    ShowMessage(strInvalidFolder);
    exit;
  end;

  fSourceFiles.clear;
  int_CopyCount:=0;
  
  //Find the music files
  MusicType:=FindMusicType(EditPath.Text);

  if MusicType=mtNONE then
  begin
    showmessage(strNoMusicFound);
    exit;
  end;

  if MusicType=mtTTARCH then
    int_CopyCount:=CopyFilesFromTtarch
  else
  if MusicType=mtOGG then
    int_CopyCount:=CopyFiles;

   if int_CopyCount = 0 then
    ShowMessage('No files created! An error occured')
   else
    ShowMessage('All done! ' + inttostr(int_CopyCount) + ' files created.');
end;

function TfrmMain.CopyFiles: integer;
var
  DestPath: string;
  str_Header: ansistring;
  i, int_StartPos: integer;
  SourceFile, DestFile: TFileStream;
begin
  Result:=0;
  ProgressBar1.Max:=fSourceFiles.Count;
  EnableControls(false);

  for i:=0 to fSourceFiles.Count -1 do
  begin
    DestPath:=IncludeTrailingPathDelimiter( DirEditDest.Text ) + pathextractfilenamenoext(fSourceFiles.Strings[i]) + '.ogg';

    SourceFile:=tfilestream.Create(IncludeTrailingPathDelimiter( EditPath.text ) + fSourceFiles.Strings[i], fmopenread);
    try
      DestFile:=tfilestream.Create(DestPath, fmOpenWrite or fmCreate);
      try
        Setlength(str_Header, 4);
        SourceFile.Read(str_Header[1], 4);

        if str_header = 'ERTM' then int_StartPos:=93
        else
          int_StartPos:=126;

        SourceFile.Seek(int_StartPos, sofrombeginning);
        DestFile.CopyFrom(SourceFile, SourceFile.Size - int_StartPos);
        inc(Result);
      finally
        DestFile.Free;
      end;
    finally
      SourceFile.Free;
    end;

    progressbar1.Position:=i;
  end;

  EnableControls(true);
  Progressbar1.Position:=0;
end;




{*********************************Ttarch stuff*********************************}

procedure TfrmMain.FindMusicTtarchBundles(Dir: string);
var
  TtarchFiles: TStringList;
  i: integer;
begin
  fTtarchFileName:='';
  Dir:=IncludeTrailingPathDelimiter(Dir);

  TtarchFiles:=Tstringlist.Create;
  try
    //First find ttarch archives in the folder
    FindFilesInDirByExt(Dir, '.ttarch', TtarchFiles);

    if TtarchFiles.Count = 0 then exit;

    for I := 0 to TtarchFiles.Count - 1 do
    begin
      //Check if any file is a music ttarch from the filename
      if Pos('MUSIC', AnsiUpperCase(TtarchFiles.Strings[i])) <> 0 then
      begin
        fTtarchFileName:=TtarchFiles.Strings[i];
        break;
      end
      else //used in Wallace and Grommit onwards
      if Pos('_MS', AnsiUpperCase(TtarchFiles.Strings[i])) <> 0 then
      begin
        fTtarchFileName:=TtarchFiles.Strings[i];
        break;
      end
    end;

    //If no music ttarch found then...
    if fTtarchFileName = '' then exit;

  finally
    TtarchFiles.Free;
  end;
end;

function TfrmMain.CopyFilesFromTtarch: integer;
var
  SoundTrack: TSoundTrackManager;
  AllFiles: TStringList;
  i: integer;

begin
  Result:=0;
  try
    fBundle:=TTtarchBundleManager.Create(IncludeTrailingPathDelimiter(EditPath.text) + fTtarchFileName);
    try
      EnableControls(false);
      fBundle.ParseFiles;


      //Build a list of all the files in fBundle so the Soundtrack Manager can scan them
      AllFiles := TStringList.Create;
      try
        for I := 0 to fBundle.Count - 1 do
        begin //Add them without the file extension
          AllFiles.Add( ChangeFileExt(fBundle.FileName[i], '') );
        end;

        try
          //Create the soundtrack manager so it can see if any valid ini files exist
          SoundTrack := TSoundTrackManager.Create(ExtractFilePath(Application.ExeName) + strSoundTrackDir, AllFiles);
          try
            if MessageDlg(strDumpSoundtrack,
                          mtConfirmation,
                          mbYesNo,
                          0)
            = mrYes then
              Result := DoTtarchFilesWithSoundTrack(SoundTrack, AllFiles)
            else
              Result :=DoTtarchFiles;

          finally
            SoundTrack.Free;
          end;
        except on E: EInvalidIniFile do
          begin
            //if SoundTrack <> nil then SoundTrack.Free;
            Result :=DoTtarchFiles;
          end;
        end;

      finally
        AllFiles.Free;
      end;



    finally
      fBundle.Free;
      EnableControls(true);
      Progressbar1.Position:=0;
    end;
  except on E: EInvalidFile do
  begin
    fBundle.Free;
    EnableControls(true);
    Progressbar1.Position:=0;
    ShowMessage(strTtarchError + ' ' +  fTtarchFileName);
  end;
  end;
end;




function TfrmMain.DoTtarchFiles: integer;
var
  i, MusicCount: integer;
  TempStream: TTelltaleMemoryStream;
  DestPath: string;
  DestFile: TFileStream;
begin
  Result:=0;
  //First count how many aud files there are
  MusicCount:=0;
  for I := 0 to fBundle.Count - 1 do
  begin
    if Uppercase( ExtractFileExt( fBundle.FileName[i] )) = '.AUD' then
      inc(MusicCount);
  end;

  ProgressBar1.Max:=MusicCount;
  ProgressBar1.Position:=0;
  if MusicCount = 0 then exit;

  TempStream:=TTelltaleMemoryStream.Create;
  try
    for I := 0 to fBundle.Count - 1 do
    begin
      if Uppercase( ExtractFileExt( fBundle.FileName[i] )) <> '.AUD' then
        continue;

      DestPath:=IncludeTrailingPathDelimiter(DirEditDest.Text) + ChangeFileExt(fBundle.FileName[i], '.ogg');
      DestFile:=tfilestream.Create(DestPath, fmOpenWrite or fmCreate);
      try
        TempStream.Clear;
        fBundle.SaveFileToStream(i, TempStream);
        if TempStream.Size <=52 then continue;

        TempStream.Position:=52; //Newer aud's have ogg at offset 52 or 56
        if TempStream.ReadString(4) = 'OggS' then
          TempStream.Position:=52
        else
        if TempStream.ReadString(4) = 'OggS' then
          TempStream.Position:=56
        else
          Continue;

        DestFile.CopyFrom(TempStream, TempStream.Size - TempStream.Position);
        inc(Result);
      finally
        DestFile.Free;
      end;

      progressbar1.Position:=progressbar1.Position + 1;
    end;
  finally
    TempStream.Free;
  end;
end;

function TfrmMain.DoTtarchFilesWithSoundTrack(SoundTrack: TSoundTrackManager; BundleFileList: TStringList): integer;
var
  i, j, BundleFileIndex, MultipleFileIndex, MusicCount, MultipleFileCount: integer;
  TempStream: TTelltaleMemoryStream;
  DestPath, NewName: string;
  DestFile: TFileStream;
  CombinationFiles: TStringList;
  SearchResult: boolean;
begin
  Result:=0;

  //First count how many files there are
  MusicCount := SoundTrack.Count;

  ProgressBar1.Max:=MusicCount;
  ProgressBar1.Position:=0;
  if MusicCount = 0 then exit;

  TempStream:=TTelltaleMemoryStream.Create;
  try
    for I := 0 to SoundTrack.Count - 1 do
    begin
      //First see if the soundtrack file exists in the bundle
      BundleFileIndex := BundleFileList.IndexOf(SoundTrack.OriginalFileNames[i]);
      if BundleFileIndex = -1 then
        continue;

      NewName := '';
      NewName := SoundTrack.NewName[BundleFileList[BundleFileIndex]];
      if NewName = '' then
        continue;




      MultipleFileCount := SoundTrack.CombinationFileCount[BundleFileList[BundleFileIndex]];
      if  MultipleFileCount > 0 then  //Have to handle multiple files differently
      begin
        CombinationFiles := TStringList.Create;
        try
          SearchResult := Soundtrack.CombinationFiles[CombinationFiles, MultipleFileCount, BundleFileList[BundleFileIndex]];
          if SearchResult = false then continue;

          //Dump the first file
          DestPath:=IncludeTrailingPathDelimiter(DirEditDest.Text) + ChangeFileExt(NewName, '.ogg');
          DestFile:=tfilestream.Create(DestPath, fmOpenWrite or fmCreate);
          try
            TempStream.Clear;
            fBundle.SaveFileToStream(BundleFileIndex, TempStream);
            if TempStream.Size <=52 then continue;

            TempStream.Position:=52; //Newer aud's have ogg at offset 52 or 56
            if TempStream.ReadString(4) = 'OggS' then
              TempStream.Position:=52
            else
            if TempStream.ReadString(4) = 'OggS' then
              TempStream.Position:=56
            else
              Continue;

            DestFile.CopyFrom(TempStream, TempStream.Size - TempStream.Position);
            inc(Result);

            //Now copy the other files to the end of this one
              for j := 0 to MultipleFileCount - 1 do
              begin
                TempStream.Clear;

                //Match the next file up
                MultipleFileIndex := BundleFileList.IndexOf(CombinationFiles[j]);

                fBundle.SaveFileToStream(MultipleFileIndex, TempStream);
                if TempStream.Size <=52 then continue;

                TempStream.Position:=52; //Newer aud's have ogg at offset 52 or 56
                if TempStream.ReadString(4) = 'OggS' then
                  TempStream.Position:=52
                else
                if TempStream.ReadString(4) = 'OggS' then
                  TempStream.Position:=56
                else
                  Continue;

                DestFile.CopyFrom(TempStream, TempStream.Size - TempStream.Position);
            end;

          finally
            DestFile.Free;
          end;

          progressbar1.Position:=progressbar1.Position + 1;

        finally
          CombinationFiles.Free;
        end;

        //Tag the file
        TagMusic(DestPath,
                  SoundTrack.Title[BundleFileList[BundleFileIndex]],
                  SoundTrack.Album,
                  SoundTrack.Artist,
                  SoundTrack.Genre,
                  SoundTrack.TrackNo[BundleFileList[BundleFileIndex]],
                  SoundTrack.Year,
                  SoundTrack.CoverArt);

        continue;
      end;




      DestPath:=IncludeTrailingPathDelimiter(DirEditDest.Text) + ChangeFileExt(NewName, '.ogg');
      DestFile:=tfilestream.Create(DestPath, fmOpenWrite or fmCreate);
      try
        TempStream.Clear;
        fBundle.SaveFileToStream(BundleFileIndex, TempStream);
        if TempStream.Size <=52 then continue;

        TempStream.Position:=52; //Newer aud's have ogg at offset 52 or 56
        if TempStream.ReadString(4) = 'OggS' then
          TempStream.Position:=52
        else
        if TempStream.ReadString(4) = 'OggS' then
          TempStream.Position:=56
        else
          Continue;

        DestFile.CopyFrom(TempStream, TempStream.Size - TempStream.Position);
        inc(Result);
      finally
        DestFile.Free;
      end;

      progressbar1.Position:=progressbar1.Position + 1;

      //Tag the file
      TagMusic(DestPath,
                SoundTrack.Title[BundleFileList[BundleFileIndex]],
                SoundTrack.Album,
                SoundTrack.Artist,
                SoundTrack.Genre,
                SoundTrack.TrackNo[BundleFileList[BundleFileIndex]],
                SoundTrack.Year,
                SoundTrack.CoverArt);
    end;
  finally
    TempStream.Free;
  end;
end;

procedure TfrmMain.TagMusic(FileName, Title, Album, Artist, Genre, TrackNo, Year, Coverart: string);
var
  SourceCover: string;
begin
  TagEditor1.FileName := Ansistring(FileName);

  if TagEditor1.Valid = false then exit;

  TagEditor1.Title    := Title;
  TagEditor1.Album    := Album;
  TagEditor1.Artist   := Artist;
  TagEditor1.Genre    := Genre;
  TagEditor1.Track    := TrackNo;
  TagEditor1.Year     := Year;
  TagEditor1.Comment  := strCommentTag + strProgVersion + ' ' + strProgURL;

  TagEditor1.Save;

  if CoverArt <> '' then
  begin
    SourceCover := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName) + strSoundTrackDir) + Coverart;
    if FileExists(SourceCover) then
      FileCopy( SourceCover, ExtractFilePath(FileName) + Coverart, false);
  end;
end;




{*****************************Popup Menu Handlers*****************************}
procedure TfrmMain.OpenPopupMenuHandler(Sender: TObject);
var
  SenderName, strFolder: string;
begin
  SenderName := tmenuitem(sender).Name;

  if SenderName = 'MenuItemOpenFolder' then
    strFolder:=''
  else
  if SenderName = 'MenuItemOpenBone1' then
  begin
    strFolder:=GetTelltaleGamePath(Bone_Boneville);
  end
  else
  if SenderName = 'MenuItemOpenBone2' then
  begin
    strFolder:=GetTelltaleGamePath(Bone_CowRace);
  end
  else
  if SenderName = 'MenuItemOpenCSI' then
  begin
    strFolder:=GetTelltaleGamePath(CSI_3Dimensions, Music);
  end
  else
  if SenderName = 'MenuItemOpenCSIHardEvidence' then
  begin
    strFolder:=GetTelltaleGamePath(CSI_HardEvidence, Music);
  end
  else
  if SenderName = 'MenuItemOpenCSIDeadlyIntent' then
  begin
    strFolder:=GetTelltaleGamePath(CSI_DeadlyIntent);

    dlgBrowseForFolder.Directory := strFolder;

    ShowMessage('CSI Deadly Intent has the music for each of its 5 parts stored in separate folders. ' +
                'You''ll need to dump the music from each part manually.' + #13#13 +
                'To do this click "Open Folder", scroll down to the "Pack" folder, select one of the CSI5 folders and click the "Go" button.'
                + #13#13 +
                'For example, select the CSI501 folder to dump the music from the first part.');

  end
  else
  if SenderName = 'MenuItemOpenCultureShock' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_CultureShock);
  end
  else
  if SenderName = 'MenuItemOpenSituationComedy' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_SituationComedy);
  end
  else
  if SenderName = 'MenuItemOpenMoleMobMeatball' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_MoleMobMeatball);
  end
  else
  if SenderName = 'MenuItemOpenAbeLincoln' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_AbeLincoln);
  end
  else
  if SenderName = 'MenuItemOpenReality20' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_Reality20);
  end
  else
  if SenderName = 'MenuItemOpenBrightSideOfTheMoon' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_BrightSideMoon);
  end
  else
  if SenderName = 'MenuItemOpenIceStationSanta' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_IceStationSanta, Music);
  end
  else
  if SenderName = 'MenuItemOpenMoaiBetterBlues' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_MoaiBetterBlues, Music);
  end
  else
  if SenderName = 'MenuItemOpenNightOfTheRavingDead' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_NightOfTheRavingDead, Music);
  end
  else
  if SenderName = 'MenuItemOpenChariotsoftheDogs' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_ChariotsOfTheDogs, Music);
  end
  else
  if SenderName = 'MenuItemOpenWhatsNewBeelzebub' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_WhatsNewBeelzebub, Music);
  end
  else
  if SenderName = 'MenuItemOpenStrongBadEP1' then
  begin
    strFolder:=GetTelltaleGamePath(StrongBad_HomestarRuiner);
  end
  else
  if SenderName = 'MenuItemOpenStrongBadEP2' then
  begin
    strFolder:=GetTelltaleGamePath(StrongBad_StrongBadiaTheFree);
  end
  else
  if SenderName = 'MenuItemOpenStrongBadEP3' then
  begin
    strFolder:=GetTelltaleGamePath(StrongBad_BaddestOfTheBands);
  end
  else
  if SenderName = 'MenuItemOpenStrongBadEP4' then
  begin
    strFolder:=GetTelltaleGamePath(StrongBad_Daneresque3);
  end
  else
  if SenderName = 'MenuItemOpenStrongBadEP5' then
  begin
    strFolder:=GetTelltaleGamePath(StrongBad_8BitIsEnough);
  end
  else
  if SenderName = 'MenuItemOpenTexas' then
  begin
    strFolder:=GetTelltaleGamePath(Texas_Holdem);
  end
  else
  if SenderName = 'MenuItemOpenWallaceEP1' then
  begin
    strFolder:=GetTelltaleGamePath(WallaceAndGromit_FrightOfTheBumblebees);
  end
  else
  if SenderName = 'MenuItemOpenWallaceEP2' then
  begin
    strFolder:=GetTelltaleGamePath(WallaceAndGromit_TheLastResort);
  end
  else
  if SenderName = 'MenuItemOpenWallaceEP3' then
  begin
    strFolder:=GetTelltaleGamePath(WallaceAndGromit_Muzzled);
  end
  else
  if SenderName = 'MenuItemOpenWallaceEP4' then
  begin
    strFolder:=GetTelltaleGamePath(WallaceAndGromit_TheBogeyMan);
  end
  else
  if SenderName = 'MenuItemOpenMonkeyEP1' then
  begin
    strFolder:=GetTelltaleGamePath(Monkey_ScreamingNarwhal);
  end
  else
  if SenderName = 'MenuItemOpenMonkeyEP2' then
  begin
    strFolder:=GetTelltaleGamePath(Monkey_SpinnerCay);
  end
  else
  if SenderName = 'MenuItemOpenMonkeyEP3' then
  begin
    strFolder:=GetTelltaleGamePath(Monkey_LairLeviathan);
  end
  else
  if SenderName = 'MenuItemOpenMonkeyEP4' then
  begin
    strFolder:=GetTelltaleGamePath(Monkey_TrialExecution);
  end
  else
  if SenderName = 'MenuItemOpenMonkeyEP5' then
  begin
    strFolder:=GetTelltaleGamePath(Monkey_PirateGod);
  end
  else
  if SenderName = 'MenuItemOpenSamAndMax301' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_PenalZone);
  end
  else
  if SenderName = 'MenuItemOpenSamAndMax302' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_TombOfSammunMak);
  end
  else
  if SenderName = 'MenuItemOpenSamAndMax303' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_TheyStoleMaxsBrain);
  end
  else
  if SenderName = 'MenuItemOpenSamAndMax304' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_BeyondAlleyOfDolls);
  end
  else
  if SenderName = 'MenuItemOpenSamAndMax305' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_CityThatDaresNotSleep);
  end
  else
  if SenderName = 'MenuItemOpenPuzzleAgent101' then
  begin
    strFolder:=GetTelltaleGamePath(PuzzleAgent_Scoggins);
  end
  else
  if SenderName = 'MenuItemOpenPuzzleAgent102' then
  begin
    strFolder:=GetTelltaleGamePath(PuzzleAgent_2);
  end
  else
  if SenderName = 'MenuItemOpenCSIFatalConspiracy' then
  begin
    strFolder:=GetTelltaleGamePath(CSI_FatalConspiracy);

    dlgBrowseForFolder.Directory := strFolder;

    ShowMessage('CSI Fatal Conspiracy has the music for each of its 5 parts stored in separate folders. ' +
                'You''ll need to dump the music from each part manually.' + #13#13 +
                'To do this click "Open Folder", scroll down to the "Pack" folder, select one of the CSI6 folders and click the "Go" button.'
                + #13#13 +
                'For example, select the CSI601 folder to dump the music from the first part.');
  end
  else
  if SenderName = 'MenuItemOpenPokerInventory' then
  begin
    strFolder:=GetTelltaleGamePath(PokerNight_Inventory);
  end
  else
  if SenderName = 'MenuItemOpenBTTF1' then
  begin
    strFolder:=GetTelltaleGamePath(BackToTheFuture_ItsAboutTime);
  end
  else
  if SenderName = 'MenuItemOpenBTTF2' then
  begin
    strFolder:=GetTelltaleGamePath(BackToTheFuture_GetTannen);
  end
  else
  if SenderName = 'MenuItemOpenBTTF3' then
  begin
    strFolder:=GetTelltaleGamePath(BackToTheFuture_CitizenBrown);
  end
  else
  if SenderName = 'MenuItemOpenBTTF4' then
  begin
    strFolder:=GetTelltaleGamePath(BackToTheFuture_DoubleVisions);
  end
  else
  if SenderName = 'MenuItemOpenBTTF5' then
  begin
    strFolder:=GetTelltaleGamePath(BackToTheFuture_OutaTime);
  end
  else
  if SenderName = 'MenuItemOpenHector101' then
  begin
    strFolder:=GetTelltaleGamePath(Hector_WeNegotiateWithTerrorists);
  end
  else
  if SenderName = 'MenuItemOpenHector102' then
  begin
    strFolder:=GetTelltaleGamePath(Hector_SenselessActsOfJustice);
  end
  else
  if SenderName = 'MenuItemOpenHector103' then
  begin
    strFolder:=GetTelltaleGamePath(Hector_BeyondReasonableDoom);
  end
  else
  if SenderName = 'MenuItemOpenJurassicParkEP1' then
  begin
    strFolder:=GetTelltaleGamePath(JurassicPark_EP1);
  end
  else
  if SenderName = 'MenuItemOpenJurassicParkEP2' then
  begin
    strFolder:=GetTelltaleGamePath(JurassicPark_EP2);
  end
  else
  if SenderName = 'MenuItemOpenJurassicParkEP3' then
  begin
    strFolder:=GetTelltaleGamePath(JurassicPark_EP3);
  end
  else
  if SenderName = 'MenuItemOpenJurassicParkEP4' then
  begin
    strFolder:=GetTelltaleGamePath(JurassicPark_EP4);
  end
  else
  if SenderName = 'MenuItemOpenLawAndOrderLegacies' then
  begin
    strFolder:=GetTelltaleGamePath(LawAndOrder_Legacies);
  end
  else
  if SenderName = 'MenuItemOpenWalkingDeadEP1' then
  begin
    strFolder:=GetTelltaleGamePath(WalkingDead_ANewDay);
  end;


  if directoryexists(strFolder) = false then
  begin
    ShowMessage(strGameNotFound);
    EditPath.Text:='';
  end
  else
    EditPath.Text:=strFolder;

end;


procedure TfrmMain.MenuItemOpenFolderClick(Sender: TObject);
begin
  btnOpenClick(frmMain);
end;

procedure TfrmMain.btnOpenClick(Sender: TObject);
begin
  if dlgBrowseForFolder.Execute then
    editPath.Text:=dlgBrowseForFolder.Directory;
end;


end.