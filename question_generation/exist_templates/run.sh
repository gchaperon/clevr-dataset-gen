python generate_questions.py \
	--input-scene-file /data/CLEVR_v1.0/scenes/CLEVR_train_scenes.json \
	--template-dir exist_templates \
	--templates-per-image 5 \
	--instances-per-template 1 \
	--output-questions-file ../output/exist_train_questions.json

python generate_questions.py \
	--input-scene-file /data/CLEVR_v1.0/scenes/CLEVR_val_scenes.json \
	--template-dir exist_templates \
	--templates-per-image 5 \
	--instances-per-template 1 \
	--output-questions-file ../output/exist_val_questions.json
