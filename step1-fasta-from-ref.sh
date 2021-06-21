#!/bin/bash
# bed file to extract reference fasta

# regions and seq file
>regions.bed
>seq.tab 

# hg38 fasta location
hg38fa=/projects/bcbio/v1.2.0/genomes/Hsapiens/hg38/seq/hg38.fa


for g in  "chr1:g.118884830G>T" "chr3:g.46903320C>T" "chr6:g.100512793A>G" "chr7:g.24679294C>G" "chr7:g.24679322G>A" "chr15:g.41886164C>T"
 do
  chr=`echo $g | sed 's/:g.*$//' `
 # echo $chr

  pos=`echo $g | sed 's/^c.*:g\.//' | sed 's/[A,C,G,T]>.*$//' `
 # echo $pos
 
  start=$((pos-500))
 # echo $start
 
  end=$((pos+500))
 # echo $end

 echo $chr $start $end | awk '{print $1 "\t" $2 "\t" $3}' > regions.bed

 # get reference sequences
 bedtools getfasta -name+ -tab -fi ${hg38fa} -bed regions.bed >> seq.tab

 done
