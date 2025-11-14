#!/usr/bin/env nextflow

process COUNT {
    label 'process_high' //can be even higher!
    container 'ghcr.io/bf528/cellranger:latest'
    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(sample), path(fastqs)
    path(index)

    output:
    path("*")

    script:
    """
    cellranger count --id=${sample} \
        --transcriptome=${index} \
        --fastqs=${fastqs} \
        --create-bam=true \
        --localcores = 8
        --localmem=64
    """

    stub:
    """
    mkdir -p ${sample}/outs
    touch ${sample}/outs/web_summary.html
    """
}