BEGIN{
    printf "%-20s%-20s%-20s%-20s\n","User","Total","Sucess","Failed"    
}

{
    TOTAL[$6]+=$8
    SUCESS[$6]+=$14
    FAILED[$6]+=$17
}

END{
    for(u in TOTAL){
        printf "%-20s%-20d%-20d%-20d\n",u,TOTAL[u],SUCESS[u],FAILED[u]
    }
}
