# General purpose STAR login

setenv GROUP_DIR /afs/rhic.bnl.gov/rhstar/group

if ( -r  $GROUP_DIR/star_cshrc.csh ) then
   source $GROUP_DIR/star_cshrc.csh
endif

starver dev

exec bash
