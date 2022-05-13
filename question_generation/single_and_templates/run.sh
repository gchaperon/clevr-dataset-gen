set -e

step=$(((70000 + $(nproc) - 1)/$(nproc)))
for (( i=0; i<70000; i+=step )); do
	python generate_questions.py \
		--input-scene-file $1/scenes/CLEVR_train_scenes.json \
		--template-dir single_and_templates \
		--templates-per-image 2 \
		--instances-per-template 1 \
		--scene-start-idx $i \
		--num-scenes $step \
		--output-questions-file ../output/single_and_train_questions_${i}.json \
		&
done
wait

step=$(((15000 + $(nproc) - 1)/$(nproc)))
for (( i=0; i<15000; i+=step )); do
	python generate_questions.py \
		--input-scene-file $1/scenes/CLEVR_val_scenes.json \
		--template-dir single_and_templates \
		--templates-per-image 1 \
		--instances-per-template 1 \
		--scene-start-idx $i \
		--num-scenes $step \
		--output-questions-file ../output/single_and_val_questions_${i}.json \
		&
done
wait

python collect_questions.py \
	../output/single_and_train_questions_*.json \
	--out-file ../output/single_and_train_questions.json \
	--clean

python collect_questions.py \
	../output/single_and_val_questions_*.json \
	--out-file ../output/single_and_val_questions.json \
	--clean

