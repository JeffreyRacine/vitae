#!/opt/local/bin/bash

# crontab entry:
# 0 0 * * * /opt/local/bin/bash -l -c 'source ~/.bashrc && cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/Documents/CV/ && /opt/local/bin/bash ./CV.sh > cron.log 2>&1'

# Log the start time
start_time=$(date +%s)
echo "--- Script started at $(date) ---"

source ~/.bashrc
cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/Documents/CV/
rm -rf index_files
quarto render index.qmd
cp index.pdf vitae.pdf
echo "Updated GS info: $(date +'%Y-%m-%d %H:%M:%S')" > .tmp.git
git add index.pdf vitae.pdf index.html index_files 
git commit index.pdf vitae.pdf index.html index_files -F .tmp.git
git push

# Log the end time
end_time=$(date +%s)
echo "--- Script finished at $(date) ---"
duration=$((end_time - start_time))
hours=$((duration / 3600))
minutes=$(((duration % 3600) / 60))
seconds=$((duration % 60))
printf "Elapsed time: %02d:%02d:%02d\n" "$hours" "$minutes" "$seconds"
