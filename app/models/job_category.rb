class JobCategory < Activehash::Base
  self.data = [
    { id: 1, name: '---' }, { id: 2, name: 'デザイナー' }, { id: 3, name: 'ライター' }, { id: 4, name: 'マーケター' },
    { id: 5, name: 'インフルエンサー' }, { id: 5, name: 'Web制作' }, { id: 6, name: 'ITエンジニア' }
  ]
end
