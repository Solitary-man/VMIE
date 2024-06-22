% 同步脚本文件，一次性同步src/.下的所有文件，每次有所改动的文件通过此方法的都标记为“*”同步，该脚本无需同步
!git add src/.
!git commit -m "*更新文件"  
!git push origin main
!git status
