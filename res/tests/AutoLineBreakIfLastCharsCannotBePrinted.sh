#!/usr/bin/env bash

columns=$(tput cols);

text=${1:-"Lorem Elsass ipsum Mauris merci vielmols dolor Oberschaeffolsheim schneck habitant ch'ai aliquam sit sit und schpeck sit id, pellentesque turpis, quam, yeuh. sed Kabinetpapier Miss Dahlias Wurschtsalad non mänele wurscht ante tristique  porta tchao bissame commodo Pfourtz ! Chulia Roberstau risus, Chulien gravida semper knepfle purus dignissim quam. blottkopf, Gal. rossbolla sed eleifend barapli libero, ornare consectetur lacus ac nüdle kuglopf chambon Carola hoplageiss réchime elit sagittis Verdammi Huguette libero. Richard Schirmeck hop Yo dû. tellus varius Christkindelsmärik geht's hopla ftomi! amet flammekueche baeckeoffe mollis leverwurscht so turpis auctor, senectus nullam rhoncus leo bissame leo messti de Bischheim DNA, bredele amet, elementum non knack kartoffelsalad Racing. picon bière Pellentesque dui in, Spätzle gal wie adipiscing ac tellus et mamsell lotto-owe rucksack ullamcorper hopla Salu bissame Strasbourg ornare Morbi kougelhopf amet suspendisse libero, placerat Oberschaeffolsheim morbi schnaps gewurztraminer vielmols, Heineken condimentum hopla id munster hopla Hans geïz eget vulputate météor jetz gehts los Coopé de Truchtersheim Gal ! Salut bisamme s'guelt salu"};

while [ ${#text} -gt 0 ]; do
  line=${text:0:$columns};

  echo "${line}";

  text="${text:$columns}";
done
