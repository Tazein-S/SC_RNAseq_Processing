#!/usr/bin/env nextflow

process WGET {

    input: 
    tuple val(name),val(ftp)

    output: 
    tuple val(name), path('*bam*')

    script: 
    """
    wget $ftp
    """

    stub:
    """
    touch stub.bam
    """













}