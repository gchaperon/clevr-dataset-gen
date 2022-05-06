set -e

step=$(((70000 + $(nproc) - 1)/$(nproc)))
for (( i=0; i<70000; i+=step )); do
	python generate_questions.py \
		--input-scene-file $1/scenes/CLEVR_train_scenes.json \
		--template-dir count_templates \
		--templates-per-image 5 \
		--instances-per-template 1 \
		--scene-start-idx $i \
		--num-scenes $step \
		--output-questions-file ../output/count_train_questions_${i}.json \
		&
done
wait

step=$(((15000 + $(nproc) - 1)/$(nproc)))
for (( i=0; i<15000; i+=step )); do
	python generate_questions.py \
		--input-scene-file $1/scenes/CLEVR_val_scenes.json \
		--template-dir count_templates \
		--templates-per-image 5 \
		--instances-per-template 1 \
		--scene-start-idx $i \
		--num-scenes $step \
		--output-questions-file ../output/count_val_questions_${i}.json \
		&
done
wait

python collect_questions.py ../output/count_train_questions_*.json --out-file ../output/count_train_questions.json
python collect_questions.py ../output/count_val_questions_*.json --out-file ../output/count_val_questions.json
