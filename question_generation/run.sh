for i in {0..12500..2500}
do
python generate_questions.py \
	--input-scene-file ~/data/clevr/CLEVR_v1.0/scenes/CLEVR_val_scenes.json \
	--template-dir single_and_templates/ \
	--instances-per-template 2 \
	--output-questions-file ../output/single_and_val_questions_${i}.json \
	--scene-start-idx $i \
	--num-scenes 2500 \
	&
done
