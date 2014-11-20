#! /bin/bash
# Clean up
rm *.mp4

# Generate images and sound
for fcount in {1..300}
do
    # Images
    REDX1=$[ ( $RANDOM % 640 )  + 1 ]
    REDX2=$[ ( $RANDOM % 640 )  + 1 ]
    REDY1=$[ ( $RANDOM % 480 )  + 1 ]
    REDY2=$[ ( $RANDOM % 480 )  + 1 ]
    BLUEX1=$[ ( $RANDOM % 640 )  + 1 ]
    BLUEX2=$[ ( $RANDOM % 640 )  + 1 ]
    BLUEY1=$[ ( $RANDOM % 480 )  + 1 ]
    BLUEY2=$[ ( $RANDOM % 480 )  + 1 ]

    convert -size 640x480 xc:white -fill red -draw "rectangle $REDX1,$REDY1 $REDX2,$REDY2" -fill blue -draw "rectangle $BLUEX1,$BLUEY1 $BLUEX2,$BLUEY2" image-$fcount.png

    # Sound
    TONE=$[ ( $RANDOM % 10) ]
    cat tones/Dtmf$TONE.ogg >> temp.ogg
done

# Stitch images to video
ffmpeg -r 1 -pattern_type glob -i '*.png' -i temp.ogg -acodec libmp3lame -vcodec libx264 out.mp4

# Clean up
rm *.png
rm temp.ogg
