NB.  K-means++ algorithm

NB.  K-means++ algo is the same as the K-means algo except for the selection of
NB.  the initial centroids, which logic follows.  For English description, see
NB.  http://en.wikipedia.org/w/index.php?title=K-means%2B%2B&oldid=423799481
initialCentroids     =:  (] , randomCentroid)^:(<:@:]`(,:@:seedCentroid@:[))~        NB.  x=K , y=dataset; z=K initial centroids
  seedCentroid       =:  {~ ?@#                                                      NB.  y=dataset; z=first (random) centroid
  randomCentroid     =:  [ {~ [: wghtProb [: <./ distance/~                          NB.  x=centroids,y=dataset; z=random centroid, chosen to spread out initial values
    distance         =:  +/&.:*:@:-"1                                                NB.  x=list of centroids, y=dataset;z=Euclidean distance
    wghtProb         =:  [: <:@:{: >:@# +/\@:>`]`]} ?@:0: /:@:,~ 0,(%{:)@:(+/\)      NB.  y=relative weights;z=index of a random point, chosen uniformly wrt weighting

NB.  Having selected the initial centroids, the standard K-means algo follows
centroids            =:  ([ mean/.~ closestCentroid)^:(]`_:`initialCentroids)        NB.  x=K, y=dataset
  closestCentroid    =:  [: (i.<./)"1 distance/                                      NB.  x=dataset,y=centroids
  mean               =:  +/ % #                                                      NB.  y=data to average

NB.  Visualization code (ripped off from Max Harms, 2011-05-26)
NB.  https://github.com/Raelifin/K-Means-Clustering-in-J/blob/master/k-meansClustering.ijs#L45
packPoints           =:  <"1@:|:                                                     NB.  or without transpose:  <@:,;.1~ 1:
plotClusters         =:  dyad define                                                 NB. x=centroids, y=clusters; only works on 2D clusters because it's a 2D plot
	require 'plot'

	pd 'reset;aspect 1;type dot;pensize 2'
	pd@:packPoints&> y
	
	pd 'type marker;markersize 1.5;color 0 0 0'
	pd@:packPoints x

	pd 'markersize 0.8;color 255 255 0'
	pd@:packPoints x
	
	pd 'show'
)


NB.  =============================
NB.  Example usage/exercise code. 
randMatrix           =:  ?@$&0
plotRandomClusters   =:  3&$: : (dyad define)  NB. x=K (# clusters), y= shape of dataset (# points x # dimensions)
	dataset          =.  randMatrix 2 {. y,2   NB. Default K is 3, default dimensionality is 2 (cartesian plane)

	centers          =.  x centroids dataset
	clusters         =.  centers (closestCentroid~ </. ])  dataset
	centers plotClusters clusters
)

plotRandomClusters 300                         NB.  300 points, 3 clusters
NB.  6 plotRandomClusters 30000                NB.  3e5 points, 6 clusters (takes a while)

