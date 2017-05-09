ROOT=$(cd "$(dirname $0)/.."; pwd)

data_path="${ROOT}/data"
if [ ! -d "$data_path" ]; then
  mkdir -p "$data_path"
fi

mnist_data_path="${ROOT}/data/mnist.zip"
if [ ! -f "$mnist_data_path" ]; then
  wget http://data.dmlc.ml/mxnet/data/mnist.zip -P $data_path
  cd $data_path
  unzip -u mnist.zip
fi

# put yur mxnet jar file in the lib folder
MXNET_JAR_FILE=$ROOT/lib/mxnet-full_2.11-linux-x86_64-gpu-0.9.5-SNAPSHOT.jar

CLASS_PATH=$MXNET_JAR_FILE:$ROOT/target/scala-2.11/classes/:$HOME/.ivy2/cache/nu.pattern/opencv/jars/opencv-2.4.9-7.jar:$HOME/.ivy2/cache/org.scala-lang/scala-library/jars/scala-library-2.11.8.jar

DATA_PATH="${data_path}"
GPU=0

java -Xmx4G -cp $CLASS_PATH \
	example.GanMnist $DATA_PATH $GPU
