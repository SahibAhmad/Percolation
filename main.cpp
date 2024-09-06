#include <iostream>
#include <vector>
#include <string>

using namespace std;

class DSU {
    vector<int> parent, rank;
public:
    DSU(int n) : parent(n), rank(n, 0) {
        for (int i = 0; i < n; i++) parent[i] = i;
    }
    
    int find(int x) {
        if (parent[x] != x) parent[x] = find(parent[x]);
        return parent[x];
    }
    
    void unite(int x, int y) {
        x = find(x), y = find(y);
        if (x == y) return;
        if (rank[x] < rank[y]) swap(x, y);
        parent[y] = x;
        if (rank[x] == rank[y]) rank[x]++;
    }
};

class Percolation {
    int n, m;
    vector<vector<bool>> grid;
    DSU dsu;
    int top, bottom;
    
    int dx[4] = {-1, 1, 0, 0};
    int dy[4] = {0, 0, -1, 1};
    
    int index(int i, int j) { return i * m + j; }
    bool isValid(int i, int j) { return i >= 0 && i < n && j >= 0 && j < m; }
    
public:
    Percolation(vector<string>& input) : n(input.size()), m(input[0].size()), 
                                         grid(n, vector<bool>(m)), 
                                         dsu(n * m + 2) {
        top = n * m;
        bottom = n * m + 1;
        
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (input[i][j] == '.') {
                    grid[i][j] = true;
                    if (i == 0) dsu.unite(index(i, j), top);
                    if (i == n - 1) dsu.unite(index(i, j), bottom);
                    
                    for (int k = 0; k < 4; k++) {
                        int ni = i + dx[k], nj = j + dy[k];
                        if (isValid(ni, nj) && grid[ni][nj]) {
                            dsu.unite(index(i, j), index(ni, nj));
                        }
                    }
                }
            }
        }
    }
    
    bool percolates() {
        return dsu.find(top) == dsu.find(bottom);
    }
    
    vector<vector<char>> getPath() {
        vector<vector<char>> path(n, vector<char>(m, '#'));
        if (!percolates()) return path;
        
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (grid[i][j] && dsu.find(index(i, j)) == dsu.find(top)) {
                    path[i][j] = '-';
                }
            }
        }
        return path;
    }
};

int main() {
    int n, m;
    cout << "Enter the dimensions of grid (row,col)" <<endl;
    cin >> n >> m;
    cout << "Enter grid values ('.' for open & '#' for blocked) \ne.g: \n##.\n...\n#.#\n" << endl;

    vector<string> input(n);
    for (int i = 0; i < n; i++) {
        cin >> input[i];
    }
    
    Percolation perc(input);
    
    if (perc.percolates()) {
        cout << "The system percolates.\n";
        auto path = perc.getPath();
        for (const auto& row : path) {
            for (char cell : row) {
                cout << cell;
            }
            cout << '\n';
        }
    } else {
        cout << "The system does not percolate.\n";
    }
    
    return 0;
}
