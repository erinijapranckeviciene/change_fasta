#!/bin/bash
# bed file to extract reference fasta
# call bash change-fasta.sh
# seq file seq.tab
>regions.bed
>changed.fasta

# hg38 fasta location
hg38fa=/projects/bcbio/v1.2.0/genomes/Hsapiens/hg38/seq/hg38.fa


for g in "chr3:g.46902784l2-T>C" "chr7:g.24679091l4-A>C" "chr15:g.41885957l6-T>C"
 do
echo ""
echo change $g
echo ""

  chr=`echo $g | sed 's/:g.*$//' `
 # echo $chr

  pos=`echo $g | sed 's/^c.*:g\.//' | sed 's/l.*$//' `
  echo $pos
 
  start=$((pos-5))
  echo $start
 
  end=$((pos+5))
  echo $end

  line=`echo $g | sed 's/^.*l//' | sed 's/-.*$//' `
  echo line in seq.tab $line

  change=`echo $g | sed 's/^.*-//' `
  echo $change
  changelet=`echo $g | sed 's/^.*>//' `
  echo $changelet

 echo $chr $start $end | awk '{print $1 "\t" $2 "\t" $3}' > regions.bed

 # get reference sequences
 subseq=`bedtools getfasta -name+ -tab -fi ${hg38fa} -bed regions.bed | awk '{print $2}' `
 subseqid=`bedtools getfasta -name+ -tab -fi ${hg38fa} -bed regions.bed | awk '{print $1}' `

 echo subseq ${subseqid} ${subseq}
 theStr=${subseq:0:4}-${subseq:5}
 echo $theStr

 changedStr=${subseq:0:4}${changelet}${subseq:5}
 echo  changed subseq $changedStr

 # grep the substring in the string
 echo ""
 echo original fasta
 sed -n "${line}p" seq.tab | grep --color "${subseq}"

 #  change the substring and grep to show the change
 echo ""
 echo changed fasta
 sed -n "${line}p" seq.tab | sed "s/${subseq}/${changedStr}/" | grep --color "${changedStr}"
 sed -n "${line}p" seq.tab | sed "s/${subseq}/${changedStr}/" >> changed.fasta

done
